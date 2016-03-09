import Quick
import Nimble
@testable import GetLanguages

class RandomColorMakerSpec: QuickSpec {
    override func spec() {
        describe("RandomColorMaker") {
            it("provides color") {
                let maker: ColorMakerType = RandomColorMaker()
                for _ in 0...100 {
                    expect(maker.color).notTo(beNil())
                }
            }
        }
    }
}
