//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import APIKit

class LanguageCatcherAPIDataManager: LanguageCatcherAPIDataManagerType {

    let fetchedProperty: AnyProperty<Bool>
    let errorProperty:   AnyProperty<LanguageCatcherAPIDataManagerError?>

    private let _fetchedProperty = MutableProperty(false)
    private let _errorProperty   = MutableProperty<LanguageCatcherAPIDataManagerError?>(nil)

    init() {
        fetchedProperty = AnyProperty(initialValue: false, producer: _fetchedProperty.producer)
        errorProperty = AnyProperty(initialValue: nil, producer: _errorProperty.producer)
    }

    func fetchData() {
        var request = WikipediaCategoryRequest()
        request.categoryName = "プログラミング言語"
        Session.sendRequest(request) {
            [weak self] result in
            switch result {
            case .Success:
                self?._fetchedProperty.value = true
            case .Failure:
                self?._fetchedProperty.value = false
                self?._errorProperty.value = .UnableToFetchData
            }
        }
    }

}
