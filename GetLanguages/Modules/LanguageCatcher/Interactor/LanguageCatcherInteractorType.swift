//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

protocol LanguageCatcherInteractorType {

    var fetchedLanguageSignal: Signal<LanguageType, NoError> { get }

    var preparedProperty: AnyProperty<Bool> { get }

    var errorMessageSignal: Signal<String?, NoError> { get }

    func fetchLanguage()

}
