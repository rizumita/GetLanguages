//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa

class LanguageCatcherPresenter: LanguageCatcherPresenterType {

    let languageViewModelProperty: AnyProperty<UnconfirmedLanguageViewModel?>
    private let _languageViewModelProperty = MutableProperty<UnconfirmedLanguageViewModel?>(nil)

    init() {
        languageViewModelProperty = AnyProperty(initialValue: nil, producer: _languageViewModelProperty.producer)
    }

    func bringLanguages() {
        let language = ProgrammingLanguage(id: NSUUID().UUIDString,
                                           name: "Test language",
                                           description: "Test description")
        _languageViewModelProperty.value = UnconfirmedLanguageViewModel(language: language,
                                                                        positionMaker: RandomPositionMaker(),
                                                                        colorMaker: RandomColorMaker())
    }

}
