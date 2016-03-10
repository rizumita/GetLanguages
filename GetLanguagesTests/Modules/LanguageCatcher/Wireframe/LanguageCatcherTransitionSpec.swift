import Quick
import Nimble
import TransitionOperator
@testable import GetLanguages

class LanguageCatcherTransitionSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherTransition") {
            it("provides caught language list operation") {
                let catcherPresenter = TestingLanguageCatcherPresenter()
                let executor = TestingTransitionExecutor()
                let destinationWireframe = CaughtLanguageListWireframe(presenter: TestingCaughtLanguageListPresenter())
                executor.transitionOperator = TransitionOperator(LanguageCatcherTransition.caughtLanguageListOperation(TestingTransitionExecutor.self, LanguageCatcherWireframe(presenter: catcherPresenter), destinationWireframe))
                executor.perform(UIViewController(nibName: nil, bundle: nil), UIViewController(nibName: nil, bundle: nil))

                expect(destinationWireframe.presenter.basket).toNot(beNil())
            }
        }
    }
}
