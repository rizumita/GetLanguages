//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject

class CaughtLanguageListAssembly: AssemblyType {

    func assemble(container: Container) {
        try! container.applyPropertyLoader(loader)

        container.register(CaughtLanguageListWireframe.self) {
            r in
            return CaughtLanguageListWireframe(presenter: r.resolve(CaughtLanguageListPresenterType.self)!)
        }.inObjectScope(.Hierarchy)

        container.register(CaughtLanguageListPresenterType.self) {
            r in
            return CaughtLanguageListPresenter()
        }.inObjectScope(.Hierarchy)

        container.registerForStoryboard(CaughtLanguageListViewController.self) {
            r, c in
            assembler.resolver.resolve(CaughtLanguageListWireframe.self)?.viewController = c
        }
    }

}
