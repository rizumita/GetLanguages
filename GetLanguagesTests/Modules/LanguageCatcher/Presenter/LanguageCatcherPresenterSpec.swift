import Quick
import Nimble
@testable import GetLanguages

class LanguageCatcherPresenterSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherPresenter") {
            it("brings language") {
                let presenter: LanguageCatcherPresenterType = LanguageCatcherPresenter()
                presenter.bringLanguages()
                expect(presenter.languageViewModelProperty.value).notTo(beNil())
            }
        }
    }
}
