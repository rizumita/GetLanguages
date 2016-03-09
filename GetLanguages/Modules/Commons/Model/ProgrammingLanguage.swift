//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import RealmSwift
import Himotoki

class ProgrammingLanguage: Object, Decodable, LanguageType {

    dynamic private(set) var id: Int = 0

    dynamic private(set) var name: String = ""

    dynamic private(set) var content: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    class func decode(e: Extractor) throws -> ProgrammingLanguage {
        let realm = try Realm()
        let id: Int = try e <| "pageid"
        if let item = realm.objectForPrimaryKey(ProgrammingLanguage.self, key: id) {
            return item
        } else {
            realm.beginWrite()
            let item = ProgrammingLanguage()
            item.id = id
            item.name = try e <| "title"
            realm.add(item)
            try realm.commitWrite()
            return item
        }
    }

    convenience init(id: Int, name: String, content: String) {
        self.init()
        self.id = id
        self.name = name
        self.content = content
    }
}
