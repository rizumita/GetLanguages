//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import TransitionOperator

class CaughtLanguageListPresenter: CaughtLanguageListPresenterType {
    var basket: Basket?

    func showDetail(index: Int, send: (AnyObject?) -> ()) {
        send(TransitionPayload(value: basket?[index]))
    }
}
