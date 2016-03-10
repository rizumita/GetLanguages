//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

class LanguageDetailInteractor: LanguageDetailInteractorType {

    let fetchedLanguageSignal: Signal<LanguageType, NoError>
    private let fetchedLanguageObserver: Observer<LanguageType, NoError>

    private let dataManager: LanguageDetailAPIDataManager

    init(dataManager: LanguageDetailAPIDataManager) {
        self.dataManager = dataManager

        (fetchedLanguageSignal, fetchedLanguageObserver) = Signal.pipe()

        self.dataManager.fetchedLanguageSignal.map(LanguageInfoTranslator().translate).observe(fetchedLanguageObserver)
    }

    func fetchContentWithID(id: Int) {
        dataManager.fetchLanguageWithID(id)
    }

}
