import Quick
import Nimble
@testable import GetLanguages

class BasketSpec: QuickSpec {
    override func spec() {
        describe("Basket") {
            it("adds language") {
                let basket = Basket()

                for index in 0...100 {
                    basket.addItem(LanguageInfo(id: index, name: "name_\(index)", content: "content_\(index)"))
                    expect(basket[index]!.id) == index
                    expect(basket[index]!.name) == "name_\(index)"
                    expect(basket[index]!.content) == "content_\(index)"
                    expect(basket.count) == index + 1
                }
            }
        }
    }
}
