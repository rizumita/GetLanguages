//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject

class LanguageCatcherAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(LanguageCatcherPresenterType.self) {
            r in
            return LanguageCatcherPresenter()
        }
    }

}

extension SwinjectStoryboard {

    class func setup() {
        defaultContainer.registerForStoryboard(LanguageCatcherViewController.self) {
            r, c in
            c.presenter = assembler.resolver.resolve(LanguageCatcherPresenterType.self)
        }
    }

}
