//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import TransitionOperator

struct LanguageCatcherTransition {

    static func caughtLanguageListOperation<T: TransitionExecutorType>(executorType: T.Type, _ sourceWireframe: LanguageCatcherWireframe,
                                            _ destinationWireframe: CaughtLanguageListWireframe)
                    -> (T, UIViewController, UIViewController) throws -> () {
        return {
            _, _, _ in
            destinationWireframe.showWithBasket(sourceWireframe.presenter.basket)
        }
    }

}
