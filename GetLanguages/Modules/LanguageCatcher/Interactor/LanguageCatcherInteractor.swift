//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import Rex
import Swiftz

enum LanguageCatcherInteractorError: ErrorType {
    case Timeout
}

class LanguageCatcherInteractor: LanguageCatcherInteractorType {

    let fetchedLanguageSignal: Signal<LanguageType, NoError>
    let preparedProperty:      AnyProperty<Bool>
    let errorMessageSignal:    Signal<String?, NoError>

    private let fetchedLanguageObserver: Observer<LanguageType, NoError>
    private let errorMessageObserver:    Observer<String?, NoError>

    private let localDataManager: LanguageCatcherLocalDataManagerType
    private let APIDataManager:   LanguageCatcherAPIDataManagerType
    private let translator:       Translator<LanguageType, LanguageType>

    private let disposable = CompositeDisposable()

    init(localDataManager: LanguageCatcherLocalDataManagerType, APIDataManager: LanguageCatcherAPIDataManagerType, translator: Translator<LanguageType, LanguageType>) {
        self.localDataManager = localDataManager
        self.APIDataManager = APIDataManager
        self.translator = translator

        let existsLanguage = localDataManager.existsLanguages
        if !existsLanguage {
            self.APIDataManager.fetchData()
        }

        (fetchedLanguageSignal, fetchedLanguageObserver) = Signal.pipe()
        (errorMessageSignal, errorMessageObserver) = Signal.pipe()

        disposable += self.APIDataManager.errorProperty.producer.map {
            _ in "Unable to fetch data"
        }.start(errorMessageObserver)
        preparedProperty = AnyProperty(initialValue: existsLanguage, producer: self.APIDataManager.fetchedProperty.producer)
    }

    func fetchLanguage() {
        guard let fetched = localDataManager.fetchRandomly() else {
            return
        }

        fetchedLanguageObserver.sendNext(translator.translate(fetched))
    }

}
