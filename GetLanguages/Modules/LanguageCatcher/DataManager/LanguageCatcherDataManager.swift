//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import RealmSwift

class LanguageCatcherLocalDataManager: LanguageCatcherLocalDataManagerType {

    var existsLanguages: Bool {
        guard let realm = try? Realm() else {
            return false
        }

        return realm.objects(ProgrammingLanguage.self).count > 0
    }

    func fetchRandomly() -> ProgrammingLanguage? {
        guard let realm = try? Realm() else {
            return nil
        }

        let languages = realm.objects(ProgrammingLanguage.self)
        let count = languages.count

        if count == 0 {
            return nil
        }

        let index = arc4random_uniform(UInt32(languages.count - 1))
        let result = languages[Int(index)]
        return result
    }

}
