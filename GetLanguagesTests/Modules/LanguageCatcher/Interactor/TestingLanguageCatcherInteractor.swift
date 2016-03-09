//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
@testable import GetLanguages

struct TestingLanguageCatcherInteractor: LanguageCatcherInteractorType {

    let fetchedLanguageSignal: Signal<LanguageType, NoError>
    let preparedProperty:      AnyProperty<Bool>
    let errorMessageSignal:    Signal<String?, NoError>

    private let fetchedlanguageObserver: Observer<LanguageType, NoError>
    private let errorMessageObserver:    Observer<String?, NoError>
    let _preparedProperty = MutableProperty(false)

    init() {
        (fetchedLanguageSignal, fetchedlanguageObserver) = Signal.pipe()
        (errorMessageSignal, errorMessageObserver) = Signal.pipe()
        preparedProperty = AnyProperty(initialValue: false, producer: _preparedProperty.producer)
    }

    func fetchLanguage() {
        fetchedlanguageObserver.sendNext(LanguageInfo(id: 1, name: "testname", content: "testcontent"))
    }

}
