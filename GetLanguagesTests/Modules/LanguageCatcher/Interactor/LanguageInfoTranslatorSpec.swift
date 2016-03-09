import Quick
import Nimble
@testable import GetLanguages

class LanguageInfoTranslatorSpec: QuickSpec {
    override func spec() {
        describe("LanguageInfoTranslator") {
            it("translates programming language") {
                let language = ProgrammingLanguage(id: 1, name: "testname", content: "testcontent")
                let translated = LanguageInfoTranslator().translate(language)
                expect(translated.id) == 1
                expect(translated.name) == "testname"
                expect(translated.content) == "testcontent"
            }
        }
    }
}
