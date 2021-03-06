import Quick
import Nimble
import UIKit
@testable import GetLanguages

class UnconfirmedLanguageViewSpec: QuickSpec {
    override func spec() {
        describe("UnconfirmedLanguageView") {
            let fieldView     = FieldView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 500.0))
            let language      = LanguageInfo(id: 1, name: "testname", content: "testcontent")
            let positionMaker = StaticPositionMaker(positions: [CGPoint(x: 100.0, y: 100.0), CGPoint(x: 110.0, y: 110.0)])
            let colorMaker    = StaticColorMaker()
            let viewModel     = UnconfirmedLanguageViewModel(language: language,
                                                             positionMaker: positionMaker,
                                                             colorMaker: colorMaker,
                                                             size: 50.0,
                                                             actionDuration: 4.0)
            let view          = UnconfirmedLanguageView(viewModel: viewModel)

            it("has properties") {
                expect(CGColorEqualToColor((view.layer as! CAShapeLayer).fillColor, UIColor.redColor().CGColor)) == true
                expect(view.frame.width) == 50.0
                expect(view.frame.height) == 50.0
            }

            it("emerge on static position") {
                view.emergeOnField(fieldView)
                view.move()
                expect(view.currentRect.contains(CGPoint(x: 100.0, y: 100.0))) == true
            }
        }
    }
}
