//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol LanguageDetailPresenterType: class {
    var language: LanguageType? { get set }
    var contentProperty: AnyProperty<String?> { get }

    func fetchContent()
}
