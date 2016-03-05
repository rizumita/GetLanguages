//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class FieldView: UIView {}

class UnconfirmedLanguageView: UIView {
    
    var nextAction: (() -> ())?
    
    func emergeOnField(fieldView: FieldView) {
        fieldView.addSubview(self)
        
        nextAction = runActionInArea(fieldView.frame.size)
        nextAction?()
    }
    
    func runActionInArea(area: CGSize) -> () -> () {
        return { [unowned self] in
            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = self.layer.valueForKey("position")
            
            let x = arc4random_uniform(UInt32(area.width))
            let y = arc4random_uniform(UInt32(area.height))
            let destination = CGPoint(x: CGFloat(x), y: CGFloat(y))
            anim.toValue = NSValue(CGPoint: destination)
            anim.removedOnCompletion = true
            anim.duration = 4
            anim.delegate = self
            self.layer.position = destination
            self.layer.addAnimation(anim, forKey: "position")
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        nextAction?()
    }
    
}

let fieldView = FieldView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 500.0))
let languageView = UnconfirmedLanguageView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
languageView.backgroundColor = UIColor.redColor()
languageView.emergeOnField(fieldView)

XCPlaygroundPage.currentPage.liveView = fieldView
