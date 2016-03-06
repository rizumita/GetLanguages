//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class UnconfirmedLanguageViewModel: UnconfirmedLanguageViewModelType {

    let size:           CGFloat
    var actionDuration: NSTimeInterval {
        let random = arc4random_uniform(UInt32(_actionDuration))
        return NSTimeInterval(random)
    }
    var color:          UIColor {
        return colorMaker.color
    }
    let shape: UIBezierPath = {
        let starPath = UIBezierPath()
        starPath.moveToPoint(CGPointMake(15, 1))
        starPath.addLineToPoint(CGPointMake(19.42, 9.92))
        starPath.addLineToPoint(CGPointMake(29.27, 11.36))
        starPath.addLineToPoint(CGPointMake(22.15, 18.32))
        starPath.addLineToPoint(CGPointMake(23.82, 28.14))
        starPath.addLineToPoint(CGPointMake(15, 23.51))
        starPath.addLineToPoint(CGPointMake(6.18, 28.14))
        starPath.addLineToPoint(CGPointMake(7.85, 18.32))
        starPath.addLineToPoint(CGPointMake(0.73, 11.36))
        starPath.addLineToPoint(CGPointMake(10.58, 9.92))
        starPath.closePath()
        return starPath
    }()

    let caughtSignal:   Signal<(), NoError>
    let caughtObsevrer: Observer<(), NoError>

    private let language:        LanguageType
    private let positionMaker:   PositionMakerType
    private let colorMaker:      ColorMakerType
    private let _actionDuration: NSTimeInterval
    private let colors:          [UIColor]
    = [.greenColor(), .redColor(), .blueColor(), .grayColor(), .cyanColor(), .blackColor(), .brownColor()]

    func positionOnArea(area: CGSize) -> CGPoint {
        return positionMaker.positionOnArea(area)
    }

    init(language: LanguageType, positionMaker: PositionMakerType, colorMaker: ColorMakerType, size: CGFloat = 30.0, actionDuration: NSTimeInterval = 4.0) {
        self.language = language
        self.positionMaker = positionMaker
        self.colorMaker = colorMaker
        self.size = size
        self._actionDuration = actionDuration

        (caughtSignal, caughtObsevrer) = Signal.pipe()
    }

}
