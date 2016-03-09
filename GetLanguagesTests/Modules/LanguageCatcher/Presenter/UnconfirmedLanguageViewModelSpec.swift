import Quick
import Nimble
import UIKit
import ReactiveCocoa
@testable import GetLanguages

class UnconfirmedLanguageViewModelSpec: QuickSpec {
    override func spec() {
        describe("UnconfirmedLanguageViewModel") {
            let language                                    = LanguageInfo(id: 1, name: "testname", content: "testcontent")
            let positionMaker                               = StaticPositionMaker(positions: [CGPoint(x: 100.0, y: 100.0), CGPoint(x: 110.0, y: 110.0)])
            let colorMaker                                  = StaticColorMaker()
            let viewModel: UnconfirmedLanguageViewModelType = UnconfirmedLanguageViewModel(language: language,
                                                                                           positionMaker: positionMaker,
                                                                                           colorMaker: colorMaker,
                                                                                           size: 50.0,
                                                                                           actionDuration: 4.0)

            it("has properties") {
                expect(viewModel.size) == 50.0
                expect(viewModel.actionDuration) <= 4.0
                expect(viewModel.color) == UIColor.redColor()
                expect(viewModel.positionOnArea(CGSizeZero)) == CGPoint(x: 100.0, y: 100.0)
                expect(viewModel.positionOnArea(CGSizeZero)) == CGPoint(x: 110.0, y: 110.0)
            }

            context("when language is caught") {
                it("propagates caught") {
                    var result: LanguageType?
                    viewModel.caughtLanguageSignal.observeNext {
                        result = $0
                    }
                    viewModel.caughtObsevrer.sendNext()

                    expect(result!.id) == 1
                    expect(result!.name) == "testname"
                    expect(result!.content) == "testcontent"
                }
            }
        }
    }
}
