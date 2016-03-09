import Quick
import Nimble
@testable import GetLanguages

class RandomPositionMakerSpec: QuickSpec {
    override func spec() {
        describe("RandomPositionMaker") {
            it("provide position in area") {
                let maker: PositionMakerType = RandomPositionMaker()

                for width in 0 ... 100 {
                    for height in 0 ... 100 {
                        let rect     = CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height))
                        let position = maker.positionOnArea(rect.size)
                        expect(position.x) >= 0.0
                        expect(position.x) <= CGFloat(width)
                        expect(position.y) >= 0.0
                        expect(position.y) <= CGFloat(height)
                    }
                }
            }
        }
    }
}
