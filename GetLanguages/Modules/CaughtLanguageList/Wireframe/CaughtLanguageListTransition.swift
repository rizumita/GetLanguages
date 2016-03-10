//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import TransitionOperator

struct CaughtLanguageListTransition {
    static func languageDetailOperation<T:TransitionExecutorType>(executorType: T.Type,
                                                                  _ wireframe: LanguageDetailWireframe)
                    -> (T, UIViewController, UIViewController) -> () {
        return {
            executor, _, _ in
            wireframe.presenter.language = executor.transitionPayload?.payloadValue as? LanguageType
        }
    }
}
