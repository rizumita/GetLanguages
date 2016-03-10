//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa

class LanguageDetailPresenter: LanguageDetailPresenterType {

    var language:        LanguageType? {
        didSet {
            _contentProperty.value = language?.content
        }
    }
    let contentProperty: AnyProperty<String?>

    private let _contentProperty = MutableProperty<String?>(nil)
    private let interactor: LanguageDetailInteractorType

    init(interactor: LanguageDetailInteractorType) {
        self.interactor = interactor
        contentProperty = AnyProperty(initialValue: nil, producer: _contentProperty.producer)

        self.interactor.fetchedLanguageSignal.observeNext {
            [weak self] in
            self?.language = $0
        }
    }

    func fetchContent() {
        guard let language = language else {
            return
        }

        if language.content.characters.count > 0 {
            _contentProperty.value = language.content
        } else {
            interactor.fetchContentWithID(language.id)
        }
    }

}
