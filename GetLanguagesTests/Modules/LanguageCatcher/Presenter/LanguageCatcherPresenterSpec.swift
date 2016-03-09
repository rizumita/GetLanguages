import Quick
import Nimble
@testable import GetLanguages

class LanguageCatcherPresenterSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherPresenter") {
            let interactor = TestingLanguageCatcherInteractor()

            context("when itreractor prepared data") {
                it("prepared data") {
                    let presenter: LanguageCatcherPresenterType
                    = LanguageCatcherPresenter(interactor: interactor,
                                               translator: UnconfirmedLanguageViewModelTranslator())
                    interactor._preparedProperty.value = true
                    expect(presenter.preparedProperty.value) == true
                    interactor._preparedProperty.value = false
                    expect(presenter.preparedProperty.value) == false
                }
            }

            it("brings language") {
                let presenter: LanguageCatcherPresenterType
                = LanguageCatcherPresenter(interactor: interactor,
                                           translator: UnconfirmedLanguageViewModelTranslator())

                var result = false
                presenter.languageViewModelSignal.observeNext {
                    _ in result = true
                }
                presenter.bringLanguages()
                expect(result) == true
            }
        }
    }
}
