//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa

enum LanguageCatcherAPIDataManagerError: ErrorType {
    case UnableToFetchData
}

protocol LanguageCatcherAPIDataManagerType {
    var fetchedProperty: AnyProperty<Bool> { get }
    var errorProperty:   AnyProperty<LanguageCatcherAPIDataManagerError?> { get }

    func fetchData()
}
