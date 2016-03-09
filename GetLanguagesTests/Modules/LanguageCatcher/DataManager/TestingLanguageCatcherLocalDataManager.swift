//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
@testable import GetLanguages

class TestingLanguageCatcherLocalDataManager: LanguageCatcherLocalDataManagerType {

    var existsLanguages: Bool {
        return language != nil
    }

    private let language: ProgrammingLanguage?

    init(language: ProgrammingLanguage? = nil) {
        self.language = language
    }

    func fetchRandomly() -> ProgrammingLanguage? {
        return language
    }
}
