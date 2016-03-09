//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
@testable import GetLanguages

class TestingLanguageCatcherPresenter: LanguageCatcherPresenterType {
    let languageViewModelSignal:   Signal<UnconfirmedLanguageViewModelType, NoError>
    let languageViewModelObserver: Observer<UnconfirmedLanguageViewModelType, NoError>
    var preparedProperty:          AnyProperty<Bool>
    var _preparedProperty = MutableProperty(false)

    init() {
        (languageViewModelSignal, languageViewModelObserver) = Signal.pipe()
        preparedProperty = AnyProperty(initialValue: false, producer: _preparedProperty.producer)
    }

    func bringLanguages() {
        guard preparedProperty.value == true else {
            return
        }

        languageViewModelObserver.sendNext(UnconfirmedLanguageViewModel(language: LanguageInfo(id: 1, name: "testname", content: "testcontent"),
                                                                        positionMaker: StaticPositionMaker(positions: [CGPoint(x: 100.0, y: 100.0), CGPoint(x: 100.0, y: 100.0)]),
                                                                        colorMaker: StaticColorMaker()))
    }
}
