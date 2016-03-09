//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol LanguageCatcherLocalDataManagerType {
    var existsLanguages: Bool { get }
    func fetchRandomly() -> ProgrammingLanguage?
}
