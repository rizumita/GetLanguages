//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import Swinject
import TransitionOperator

class LanguageCatcherAssembly: AssemblyType {

    func assemble(container: Container) {
        try! container.applyPropertyLoader(loader)

        container.register(LanguageCatcherWireframe.self) {
            r in
            return LanguageCatcherWireframe(presenter: r.resolve(LanguageCatcherPresenterType.self)!)
        }.initCompleted {
            r, w in
            w.caughtLanguageListWireframe = r.resolve(CaughtLanguageListWireframe.self)
        }.inObjectScope(.Hierarchy)

        container.register(LanguageCatcherPresenterType.self) {
            r in
            return LanguageCatcherPresenter(interactor: r.resolve(LanguageCatcherInteractorType.self)!,
                                            translator: r.resolve(Translator<LanguageType, UnconfirmedLanguageViewModelType>.self)!)
        }.inObjectScope(.Hierarchy)

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

        container.register(TransitionOperatorType.self, name: R.segue.languageCatcherViewController.caughtLanguageListSegue.identifier) {
            r in
            let operations: CompositeTransitionOperator = [
                    TransitionOperator(LanguageCatcherTransition.caughtLanguageListOperation(TransitionExecutorSegue.self,
                                                                                             r.resolve(LanguageCatcherWireframe.self)!,
                                                                                             r.resolve(CaughtLanguageListWireframe.self)!)),
                    TransitionOperator {
                        (e: TransitionExecutorSegue, s: UIViewController, d: CaughtLanguageListViewController) in
                        d.presenter = r.resolve(CaughtLanguageListWireframe.self)!.presenter
                    }]
            return operations
        }

        TransitionExecutorSegue.transitionOperator = TransitionOperator {
            (e: TransitionExecutorSegue, s: UIViewController, d: UIViewController) in
            if e.transitionOperator == nil {
                e.transitionOperator = assembler.resolver.resolve(TransitionOperatorType.self, name: e.identifier)
            }
        }
    }

}

extension SwinjectStoryboard {

    class func setup() {
        defaultContainer.registerForStoryboard(LanguageCatcherViewController.self) {
            r, c in
            assembler.resolver.resolve(LanguageCatcherWireframe.self)?.viewController = c
            c.presenter = assembler.resolver.resolve(LanguageCatcherPresenterType.self)
            c.maxLanguageNumber = assembler.resolver.property("star_number")!
        }
    }

}
