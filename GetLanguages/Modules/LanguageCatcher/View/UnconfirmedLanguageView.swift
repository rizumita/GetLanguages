//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import QuartzCore
import ReactiveCocoa

class UnconfirmedLanguageView: UIView {

    var currentRect: CGRect {
        return layer.presentationLayer()?.frame ?? layer.frame
    }

    private typealias Action = () -> ()

    private let viewModel:     UnconfirmedLanguageViewModelType
    private var fieldView:     UIView?
    private var nextAction:    Action?
    private var nextRotationX: Action?
    private var nextRotationY: Action?
    private var nextRotationZ: Action?
    private let tapGestureRecognizer = UITapGestureRecognizer()

    private let disposable = CompositeDisposable()
    private let scopedDisposable: ScopedDisposable

    init(viewModel: UnconfirmedLanguageViewModelType) {
        scopedDisposable = ScopedDisposable(disposable)
        self.viewModel = viewModel
        let rect = CGRect(x: 0.0, y: 0.0, width: viewModel.size, height: viewModel.size)

        super.init(frame: rect)

        setUpShapeLayer()
        setUpTapGesture()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }

    private func setUpShapeLayer() {
        guard let shapeLayer = layer as? CAShapeLayer else {
            return
        }

        shapeLayer.path = viewModel.shape.CGPath
        shapeLayer.fillColor = viewModel.color.CGColor
    }

    private func setUpTapGesture() {
        tapGestureRecognizer.gestureSignalProducer().map {
            _ in ()
        }.on {
            [unowned self] in
            self.removeFromSuperview()
        }.start(viewModel.caughtObsevrer)

        addGestureRecognizer(tapGestureRecognizer)
    }

    func emergeOnField(fieldView: FieldView) {
        self.fieldView = fieldView
        fieldView.addSubview(self)

    }

    func move() {
        guard let fieldView = fieldView else {
            return
        }

        layer.position = viewModel.positionOnArea(fieldView.frame.size)
        nextAction = runActionInArea()
        nextRotationX = rotationActionWithKeyPath("transform.rotation.x", key: .RotationX, baseDegree: 180.0)
        nextRotationY = rotationActionWithKeyPath("transform.rotation.y", key: .RotationY, baseDegree: 180.0)
        nextRotationZ = rotationActionWithKeyPath("transform.rotation.z", key: .RotationZ, baseDegree: 360.0)

        nextAction?()
        nextRotationX?()
        nextRotationY?()
        nextRotationZ?()
    }

    func stop() {
        nextAction = nil
        nextRotationX = nil
        nextRotationY = nil
        nextRotationZ = nil
    }

    enum AnimationKey: String {
        case Position
        case RotationX
        case RotationY
        case RotationZ
    }

    private func runActionInArea() -> Action {
        return {
            [unowned self] in
            let destination = self.viewModel.positionOnArea(self.fieldView?.frame.size ?? CGSizeZero)
            let duration    = self.viewModel.actionDuration

            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = self.layer.valueForKey("position")
            anim.toValue = NSValue(CGPoint: destination)
            anim.removedOnCompletion = false
            anim.duration = duration
            anim.delegate = self
            self.layer.position = destination
            self.layer.addAnimation(anim, forKey: AnimationKey.Position.rawValue)
        }
    }

    private func rotationActionWithKeyPath(keyPath: String, key: AnimationKey, baseDegree: Double) -> Action {
        return {
            [unowned self] in
            func degreesToRadians(degrees: Double) -> Double {
                return (M_PI * degrees) / 180
            }

            let duration = self.viewModel.actionDuration

            let anim: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
            anim.toValue = degreesToRadians((Int(duration) % 2 == 0) ? baseDegree : -baseDegree)
            anim.removedOnCompletion = false
            anim.duration = duration
            anim.additive = true
            anim.fillMode = kCAFillModeForwards
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            anim.delegate = self
            self.layer.addAnimation(anim, forKey: key.rawValue)
        }
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        guard flag == true else {
            return
        }

        if anim == layer.animationForKey(AnimationKey.Position.rawValue) {
            layer.removeAnimationForKey(AnimationKey.Position.rawValue)
            nextAction?()
        } else if anim == layer.animationForKey(AnimationKey.RotationX.rawValue) {
            layer.removeAnimationForKey(AnimationKey.RotationX.rawValue)
            nextRotationX?()
        } else if anim == layer.animationForKey(AnimationKey.RotationY.rawValue) {
            layer.removeAnimationForKey(AnimationKey.RotationY.rawValue)
            nextRotationY?()
        } else if anim == layer.animationForKey(AnimationKey.RotationZ.rawValue) {
            layer.removeAnimationForKey(AnimationKey.RotationZ.rawValue)
            nextRotationZ?()
        }
    }

    override func willMoveToSuperview(newSuperview: UIView?) {
        guard newSuperview == nil else {
            return
        }

        self.layer.removeAllAnimations()
    }

}
