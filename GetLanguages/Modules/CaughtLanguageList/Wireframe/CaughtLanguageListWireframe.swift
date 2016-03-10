//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import TransitionOperator

class CaughtLanguageListWireframe {

    let presenter: CaughtLanguageListPresenterType
    var viewController: UIViewController? {
        didSet {
            guard let controller = viewController else {
                return
            }

            controller.rac_signalForSelector("prepareForSegue:sender:").takeUntil(controller.rac_willDeallocSignal()).subscribeNext {
                [weak self] in
                let tuple = $0 as! RACTuple
                self?.prepareForSegue(tuple.first as? UIStoryboardSegue, sender: tuple.second)
            }
        }
    }

    init(presenter: CaughtLanguageListPresenterType) {
        self.presenter = presenter
    }

    func showWithBasket(basket: Basket) {
        presenter.basket = basket
    }

    func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        switch (segue, sender) {
        case (let s as TransitionExecutorSegue, let op as TransitionOperatorType):
            s.transitionOperator = op
        case (let s as TransitionExecutorSegue, let p as TransitionPayloadType):
            s.transitionPayload = p
        default: ()
        }
    }

}
