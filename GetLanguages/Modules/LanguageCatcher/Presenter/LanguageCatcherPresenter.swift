//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Rex
import Result

struct LanguageCatcherPresenter: LanguageCatcherPresenterType {

    let languageViewModelSignal: Signal<UnconfirmedLanguageViewModelType, NoError>
    let preparedProperty: AnyProperty<Bool>

    private let interactor: LanguageCatcherInteractorType
    private let translator: Translator<LanguageType, UnconfirmedLanguageViewModelType>

    init(interactor: LanguageCatcherInteractorType, translator: Translator<LanguageType, UnconfirmedLanguageViewModelType>) {
        self.interactor = interactor
        self.translator = translator

        preparedProperty = AnyProperty(initialValue: false, producer: interactor.preparedProperty.producer)

        languageViewModelSignal = self.interactor.fetchedLanguageSignal.map(translator.translate).on { (viewModel: UnconfirmedLanguageViewModelType) in
            viewModel.caughtLanguageSignal.observeNext { id in
                print(id)
            }
        }
    }

    func bringLanguages() {
        interactor.fetchLanguage()
    }

}
