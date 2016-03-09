//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject

class LanguageCatcherAssembly: AssemblyType {

    func assemble(container: Container) {
        try! container.applyPropertyLoader(loader)

        container.register(LanguageCatcherPresenterType.self) {
            r in
            return LanguageCatcherPresenter(interactor: r.resolve(LanguageCatcherInteractorType.self)!,
                                            translator: r.resolve(Translator<LanguageType, UnconfirmedLanguageViewModelType>.self)!)
        }

        container.register(Translator<LanguageType, UnconfirmedLanguageViewModelType>.self) {
            r in
            return UnconfirmedLanguageViewModelTranslator(size: r.property("star_size")!,
                                                          actionDuration: r.property("action_duration")!)
        }

        container.register(LanguageCatcherInteractorType.self) {
            r in
            return LanguageCatcherInteractor(localDataManager: r.resolve(LanguageCatcherLocalDataManagerType.self)!,
                                             APIDataManager: r.resolve(LanguageCatcherAPIDataManagerType.self)!,
                                             translator: r.resolve(Translator < LanguageType, LanguageType>)!)
        }

        container.register(Translator<LanguageType, LanguageType>.self) {
            r in
            return LanguageInfoTranslator()
        }

        container.register(LanguageCatcherLocalDataManagerType.self) {
            r in
            return LanguageCatcherLocalDataManager()
        }

        container.register(LanguageCatcherAPIDataManagerType.self) {
            r in
            return LanguageCatcherAPIDataManager()
        }
    }

}

extension SwinjectStoryboard {

    class func setup() {
        defaultContainer.registerForStoryboard(LanguageCatcherViewController.self) {
            r, c in
            c.presenter = assembler.resolver.resolve(LanguageCatcherPresenterType.self)
            c.maxLanguageNumber = assembler.resolver.property("star_number")!
        }
    }

}
