import Quick
import Nimble
@testable import GetLanguages

class UnconfirmedLanguageSpec: QuickSpec {
    override func spec() {
        describe("UnconfirmedLanguage") {
            it("can be created") {
                let language = LanguageInfo(id: 1, name: "testname", content: "testcontent")
                expect(language.id) == 1
                expect(language.name) == "testname"
                expect(language.content) == "testcontent"
            }
        }
    }
}
