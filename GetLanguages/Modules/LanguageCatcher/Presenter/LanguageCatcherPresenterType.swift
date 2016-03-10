//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

protocol LanguageCatcherPresenterType {
    var languageViewModelSignal: Signal<UnconfirmedLanguageViewModelType, NoError> { get }
    var preparedProperty: AnyProperty<Bool> { get }
    var basket: Basket { get }

    func bringLanguage()
}
