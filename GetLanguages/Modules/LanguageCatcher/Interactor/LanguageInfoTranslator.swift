//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation

class LanguageInfoTranslator: Translator<LanguageType, LanguageType> {
    override func translate(source: Source) -> Destination {
        return LanguageInfo(id: source.id, name: source.name, content: source.content)
    }
}
