//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import TransitionOperator
@testable import GetLanguages

class TestingTransitionExecutor: TransitionExecutorType {
    var transitionOperator: TransitionOperatorType?
    var transitionPayload:  TransitionPayloadType?

    func perform(source: UIViewController, _ destination: UIViewController) {
        transitionOperator?.operate(executor: self, source: source, destination: destination)
    }
}
