//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

protocol LanguageDetailInteractorType {
    var fetchedLanguageSignal: Signal<LanguageType, NoError> { get }

    func fetchContentWithID(id: Int)
}
