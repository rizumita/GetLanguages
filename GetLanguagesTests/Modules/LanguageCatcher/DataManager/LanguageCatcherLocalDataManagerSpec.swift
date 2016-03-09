import Quick
import Nimble
import RealmSwift
@testable import GetLanguages

func deleteAll() {
    let realm = try! Realm()
    realm.beginWrite()
    realm.deleteAll()
    try! realm.commitWrite()
}

class LanguageCatcherLocalDataManagerSpec: QuickSpec {
    override func spec() {
        describe("LanguageCatcherLocalDataManager") {
            let dataManager: LanguageCatcherLocalDataManagerType = LanguageCatcherLocalDataManager()

            context("when no languages exist") {
                beforeEach {
                    deleteAll()
                }

                it("return no language") {
                    expect(dataManager.fetchRandomly()).to(beNil())
                }
            }

            context("when languages exist") {
                beforeEach {
                    let realm = try! Realm()
                    realm.beginWrite()
                    realm.add(ProgrammingLanguage(id: 1, name: "testname", content: "testcontent"))
                    try! realm.commitWrite()
                }

                afterEach {
                    deleteAll()
                }

                it("return language") {
                    let language = dataManager.fetchRandomly()

                    expect(language!.id) == 1
                    expect(language!.name) == "testname"
                    expect(language!.content) == "testcontent"
                }
            }
        }
    }
}
