//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation

struct LanguageInfo: LanguageType {
    let id:      Int
    let name:    String
    let content: String

    init(id: Int, name: String, content: String) {
        self.id = id
        self.name = name
        self.content = content
    }
}
