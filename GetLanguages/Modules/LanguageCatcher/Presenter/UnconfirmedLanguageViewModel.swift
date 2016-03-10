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
    lazy var shape: UIBezierPath = {
        //// Frames
        let frame    = CGRectMake(0, 0, self.size, self.size)


        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.moveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.03333 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.64720 * frame.width, frame.minY + 0.33073 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.97553 * frame.width, frame.minY + 0.37882 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.73817 * frame.width, frame.minY + 0.61072 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.79389 * frame.width, frame.minY + 0.93784 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.78376 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.20611 * frame.width, frame.minY + 0.93784 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.26183 * frame.width, frame.minY + 0.61072 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.02447 * frame.width, frame.minY + 0.37882 * frame.height))
        starPath.addLineToPoint(CGPointMake(frame.minX + 0.35280 * frame.width, frame.minY + 0.33073 * frame.height))
        starPath.closePath()
        return starPath
    }()

    private let caughtSignal: Signal<(), NoError>
    let caughtObsevrer:       Observer<(), NoError>
    let caughtLanguageSignal: Signal<LanguageType, NoError>
    private let caughtLanguageObsevrer: Observer<LanguageType, NoError>

    private let positionMaker:   PositionMakerType
    private let colorMaker:      ColorMakerType
    private let _actionDuration: NSTimeInterval
    private let colors:          [UIColor]
    = [.greenColor(), .redColor(), .blueColor(), .grayColor(), .cyanColor(), .blackColor(), .brownColor()]

    func positionOnArea(area: CGSize) -> CGPoint {
        return positionMaker.positionOnArea(area)
    }

    private let disposable = CompositeDisposable()
    private let scopedDisposable: ScopedDisposable

    init(language: LanguageType, positionMaker: PositionMakerType, colorMaker: ColorMakerType, size: CGFloat = 30.0, actionDuration: NSTimeInterval = 4.0) {
        self.positionMaker = positionMaker
        self.colorMaker = colorMaker
        self.size = size
        self._actionDuration = actionDuration

        (caughtSignal, caughtObsevrer) = Signal.pipe()
        (caughtLanguageSignal, caughtLanguageObsevrer) = Signal.pipe()

        disposable += caughtSignal.map {
            language
        }.observe(caughtLanguageObsevrer)

        scopedDisposable = ScopedDisposable(disposable)
    }

}
