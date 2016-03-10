//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import RealmSwift
import APIKit

class LanguageDetailAPIDataManager {
    let fetchedLanguageSignal: Signal<ProgrammingLanguage, NoError>
    private let fetchedLanguageObserver: Observer<ProgrammingLanguage, NoError>

    init() {
        (fetchedLanguageSignal, fetchedLanguageObserver) = Signal.pipe()
    }

    func fetchLanguageWithID(id: Int) {
        var request = WikipediaLanguageRequest()
        request.id = id
        Session.sendRequest(request) {
            [weak self] result in
            switch result {
            case .Success(let content):
                if let language = self?.updateLanguageWithID(id, withContent: content) {
                    self?.fetchedLanguageObserver.sendNext(language)
                }
            case .Failure: ()
            }
        }
    }

    func updateLanguageWithID(id: Int, withContent content: String) -> ProgrammingLanguage? {
        guard let realm = try? Realm() else {
            return nil
        }

        if let language = realm.objectForPrimaryKey(ProgrammingLanguage.self, key: id) {
            realm.beginWrite()
            language.content = content
            try! realm.commitWrite()
            return language
        } else {
            return nil
        }
    }
}
