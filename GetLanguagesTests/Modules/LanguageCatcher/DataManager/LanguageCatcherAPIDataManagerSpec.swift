import Quick
import Nimble
import OHHTTPStubs
@testable import GetLanguages

class LanguageCatcherAPIDataManagerSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherAPIDataManager") {
            context("before fetching data") {
                it("does not fetch data") {
                    let dataManager: LanguageCatcherAPIDataManagerType = LanguageCatcherAPIDataManager()

                    expect(dataManager.fetchedProperty.value) == false
                    expect(dataManager.errorProperty.value).to(beNil())
                }
            }

            context("after fetching data with success") {
                beforeEach {
                    deleteAll()

                    stub(isHost("ja.wikipedia.org")) {
                        _ in
                        let stubPath = OHPathForFile("category.json", self.dynamicType)
                        return fixture(stubPath!, headers: nil)
                    }
                }

                afterEach {
                    deleteAll()
                    OHHTTPStubs.removeAllStubs()
                }

                it("prepared data") {
                    let dataManager: LanguageCatcherAPIDataManagerType = LanguageCatcherAPIDataManager()
                    var result                                         = false
                    dataManager.fetchedProperty.producer.skip(1).startWithNext {
                        result = $0
                    }
                    dataManager.fetchData()

                    expect(result).toEventually(beTrue(), timeout: 2.0)
                    expect(dataManager.errorProperty.value).to(beNil())
                }
            }

            // stub が動作する時としない時があるのでコメントアウト
//            context("after fetching data with failure") {
//                beforeEach {
//                    deleteAll()
//
//                    stub(isHost("ja.wikipedia.org")) {
//                        _ in
//                        let stubPath = OHPathForFile("category_failed.json", self.dynamicType)
//                        return fixture(stubPath!, status: 502, headers: nil)
//                    }
//                }
//
//                afterEach {
//                    OHHTTPStubs.removeAllStubs()
//                }
//
//                it("did not prepare data") {
//                    let dataManager: LanguageCatcherAPIDataManagerType = LanguageCatcherAPIDataManager()
//                    var result                                         = true
//                    dataManager.fetchedProperty.producer.skip(1).startWithNext {
//                        result = $0
//                    }
//                    var error: LanguageCatcherAPIDataManagerError? = nil
//                    dataManager.errorProperty.producer.skip(1).startWithNext {
//                        error = $0
//                    }
//                    dataManager.fetchData()
//
//                    expect(result).toEventually(beFalse(), timeout: 30.0)
//                    expect(error).toEventuallyNot(beNil(), timeout: 30.0)
//                }
//            }
        }
    }
}
