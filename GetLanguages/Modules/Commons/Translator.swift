//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation

class Translator<S, D>: TranslatorType {
    typealias Source = S
    typealias Destination = D

    func translate(source: Source) -> Destination {
        fatalError()
    }

}
