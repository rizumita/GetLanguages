import Quick
import Nimble
import UIKit
import ReactiveCocoa
import Rswift
@testable import GetLanguages

class LanguageCatcherViewControllerSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherViewController") {
            context("when presenter doesn’t prepare data yet") {
                it("has no language view") {
                    let controller = R.storyboard.main.initialViewController()!
                    controller.presenter = TestingLanguageCatcherPresenter()
                    _ = controller.view
                    NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeInterval: 4.0, sinceDate: NSDate()))
                    expect(controller.fieldView.subviews.count) == 0
                }
            }

            context("when presenter prepared data") {
                it("has some language view") {
                    let controller = R.storyboard.main.initialViewController()!
                    let presenter  = TestingLanguageCatcherPresenter()
                    controller.presenter = presenter
                    _ = controller.view
                    presenter._preparedProperty.value = true
                    NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeInterval: 4.0, sinceDate: NSDate()))
                    expect(controller.fieldView.subviews.count) > 0
                }
            }
        }
    }
}
