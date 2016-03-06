//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation

struct ProgrammingLanguage: LanguageType {

    let id: String

    let name: String

    let description: String

    init(id: String, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }

}
