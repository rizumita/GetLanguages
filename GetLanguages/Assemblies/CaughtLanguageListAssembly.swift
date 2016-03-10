//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject
import TransitionOperator

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
        }

        container.register(TransitionOperatorType.self, name: R.segue.caughtLanguageListViewController.languageDetailSegue.identifier) {
            r in
            return TransitionOperator(CaughtLanguageListTransition.languageDetailOperation(TransitionExecutorSegue.self,
                                                                                           r.resolve(LanguageDetailWireframe.self)!))
        }

        SwinjectStoryboard.defaultContainer.registerForStoryboard(CaughtLanguageListViewController.self) {
            r, c in
            let wireframe = assembler.resolver.resolve(CaughtLanguageListWireframe.self)

            // このクロージャがなぜか2回呼ばれるため2回目はキャンセル
            if wireframe?.viewController === c {
                return
            }

            wireframe?.viewController = c
            c.presenter = wireframe?.presenter
        }
    }

}
