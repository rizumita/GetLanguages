//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject

let assembler = try! Assembler(assemblies: [
        LanguageCatcherAssembly(),
        CaughtLanguageListAssembly(),
        LanguageDetailAssembly()
])

let loader = JsonPropertyLoader(name: "properties")
