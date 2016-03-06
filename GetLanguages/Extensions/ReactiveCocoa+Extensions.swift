//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

extension UIGestureRecognizer {
    func gestureSignalProducer<T: UIGestureRecognizer>() -> SignalProducer<T, NoError> {
        return rac_gestureSignal()
        .toSignalProducer()
        .map { $0 as! T }
        .flatMapError { _ in SignalProducer<T, NoError>.empty }
    }
}
