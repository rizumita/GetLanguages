//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

protocol UnconfirmedLanguageViewModelType {
    var size:           CGFloat { get }
    var actionDuration: NSTimeInterval { get }
    var color:          UIColor { get }
    var shape:          UIBezierPath { get }

    var caughtSignal:   Signal<(), NoError> { get }
    var caughtObsevrer: Observer<(), NoError> { get }

    func positionOnArea(area: CGSize) -> CGPoint
}
