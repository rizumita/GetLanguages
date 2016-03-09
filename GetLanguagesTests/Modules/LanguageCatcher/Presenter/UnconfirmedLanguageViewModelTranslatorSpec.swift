import Quick
import Nimble
@testable import GetLanguages

class UnconfirmedLanguageViewModelTranslatorSpec: QuickSpec {
    override func spec() {
        describe("UnconfirmedLanguageViewModelTranslator") {
            it("translates") {
                let translator: Translator<LanguageType, UnconfirmedLanguageViewModelType>
                = UnconfirmedLanguageViewModelTranslator(size: 40.0, actionDuration: 5.0)
                let language = LanguageInfo(id: 1, name: "testname", content: "testcontent")
                let translated = translator.translate(language)
                expect(translated.actionDuration) <= 5.0
                expect(translated.size) == 40.0

                var result: LanguageType?
                translated.caughtLanguageSignal.observeNext {
                    result = $0
                }
                translated.caughtObsevrer.sendNext()

                expect(result!.id) == 1
                expect(result!.name) == "testname"
                expect(result!.content) == "testcontent"
            }
        }
    }
}
