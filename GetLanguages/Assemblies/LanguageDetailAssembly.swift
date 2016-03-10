//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject

class LanguageDetailAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(LanguageDetailWireframe.self) {
            r in
            return LanguageDetailWireframe(presenter: r.resolve(LanguageDetailPresenterType.self)!)
        }.inObjectScope(.Hierarchy)

        container.register(LanguageDetailPresenterType.self) {
            r in
            return LanguageDetailPresenter(interactor: r.resolve(LanguageDetailInteractorType.self)!)
        }

        container.register(LanguageDetailInteractorType.self) {
            r in
            return LanguageDetailInteractor(dataManager: r.resolve(LanguageDetailAPIDataManager.self)!)
        }

        container.register(LanguageDetailAPIDataManager.self) {
            r in
            return LanguageDetailAPIDataManager()
        }

        SwinjectStoryboard.defaultContainer.registerForStoryboard(LanguageDetailViewController.self) {
            r, c in
            let wireframe = assembler.resolver.resolve(LanguageDetailWireframe.self)

            // このクロージャがなぜか2回呼ばれるため2回目はキャンセル
            if wireframe?.viewController === c {
                return
            }

            wireframe?.viewController = c
            c.presenter = wireframe?.presenter
        }
    }

}
