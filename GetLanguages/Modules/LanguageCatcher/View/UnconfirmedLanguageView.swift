//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class UnconfirmedLanguageView: UIView {

    let tappedSignalProducer: SignalProducer<(), NoError>

    private let disposable = CompositeDisposable()

    init(viewModel: UnconfirmedLanguageViewModelType) {
        self.viewModel = viewModel
        let rect = CGRect(x: 0.0, y: 0.0, width: viewModel.size, height: viewModel.size)

        tappedSignalProducer = tapGestureRecognizer.gestureSignalProducer().map {
            _ in ()
        }.replayLazily(1)

        super.init(frame: rect)

        backgroundColor = self.viewModel.color

        disposable += tappedSignalProducer.startWithNext {
            [unowned self] _ in
            self.removeFromSuperview()
        }

        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel:  UnconfirmedLanguageViewModelType
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var nextAction: (() -> ())?

    var currentRect: CGRect {
        return layer.presentationLayer()?.frame ?? layer.frame
    }

    func emergeOnField(fieldView: FieldView) {
        fieldView.addSubview(self)

        layer.position = viewModel.positionOnArea(fieldView.frame.size)
        nextAction = runActionInArea(fieldView.frame.size)
    }

    func move() {
        nextAction?()
    }

    private func runActionInArea(area: CGSize) -> () -> () {
        return {
            [unowned self] in
            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = self.layer.valueForKey("position")

            let destination = self.viewModel.positionOnArea(area)
            anim.toValue = NSValue(CGPoint: destination)
            anim.removedOnCompletion = true
            anim.duration = self.viewModel.actionDuration
            anim.delegate = self
            self.layer.position = destination
            self.layer.addAnimation(anim, forKey: "position")
        }
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        guard flag == true else {
            return
        }

        nextAction?()
    }

    override func willMoveToSuperview(newSuperview: UIView?) {
        guard newSuperview == nil else {
            return
        }

        self.layer.removeAllAnimations()
    }

}
