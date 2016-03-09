//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
@testable import GetLanguages

class TestingLanguageCatcherAPIDataManager: LanguageCatcherAPIDataManagerType {
    let fetchedProperty: AnyProperty<Bool>
    let errorProperty:   AnyProperty<LanguageCatcherAPIDataManagerError?>

    private let _fetchedProperty = MutableProperty(false)
    private let _errorProperty   = MutableProperty<LanguageCatcherAPIDataManagerError?>(nil)

    private let fetched: Bool
    private let error:   LanguageCatcherAPIDataManagerError?

    init(fetched: Bool, error: LanguageCatcherAPIDataManagerError? = nil) {
        self.fetched = fetched
        self.error = error

        fetchedProperty = AnyProperty(initialValue: false, producer: _fetchedProperty.producer)
        errorProperty = AnyProperty(initialValue: nil, producer: _errorProperty.producer)
    }

    func fetchData() {
        _fetchedProperty.value = fetched
        if !fetched {
            _errorProperty.value = error
        }
    }
}
