import Quick
import Nimble
import ReactiveCocoa
@testable import GetLanguages

class LanguageCatcherInteractorSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherInteractor") {
            context("when unable to fetch data") {
                let localDataManager                  = TestingLanguageCatcherLocalDataManager(language: nil)
                let APIDataManager                    = TestingLanguageCatcherAPIDataManager(fetched: false, error: .UnableToFetchData)
                let translator                        = LanguageInfoTranslator()
                let interactor:
                        LanguageCatcherInteractorType = LanguageCatcherInteractor(localDataManager: localDataManager,
                                                                                  APIDataManager: APIDataManager,
                                                                                  translator: translator)
                let errorProperty                     = MutableProperty<String?>(nil)

                beforeEach {
                    errorProperty <~ interactor.errorMessageSignal
                    APIDataManager.fetchData()
                }

                it("does not prepare") {
                    expect(interactor.preparedProperty.value) == false
                    expect(errorProperty.value).notTo(beNil())
                }

                describe("fetches language") {
                    it("signals no fetched language") {
                        var language: LanguageType?
                        interactor.fetchedLanguageSignal.observeNext {
                            language = $0
                        }

                        interactor.fetchLanguage()

                        expect(language).toEventually(beNil())
                    }
                }
            }

            context("when able to fetch data") {
                let localDataManager                  = TestingLanguageCatcherLocalDataManager(language: ProgrammingLanguage())
                let APIDataManager                    = TestingLanguageCatcherAPIDataManager(fetched: true)
                let translator                        = LanguageInfoTranslator()
                let interactor:
                        LanguageCatcherInteractorType = LanguageCatcherInteractor(localDataManager: localDataManager,
                                                                                  APIDataManager: APIDataManager,
                                                                                  translator: translator)
                let errorProperty                     = MutableProperty<String?>(nil)

                beforeEach {
                    APIDataManager.fetchData()
                }

                it("does not prepare") {
                    expect(interactor.preparedProperty.value) == true
                    expect(errorProperty.value).to(beNil())
                }

                describe("fetches language") {
                    it("signals fetched language") {
                        var language: LanguageType?
                        interactor.fetchedLanguageSignal.observeNext {
                            language = $0
                        }

                        interactor.fetchLanguage()

                        expect(language).toEventuallyNot(beNil())
                    }
                }
            }


        }
    }
}
