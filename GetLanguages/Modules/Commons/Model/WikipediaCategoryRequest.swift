//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

struct WikipediaCategoryRequest: WikipediaRequestType {
    typealias Response = [ProgrammingLanguage]

    var categoryName: String = ""

    var method: HTTPMethod {
        return .GET
    }

    var parameters: [String:AnyObject] {
        return ["format": "json",
                "action": "query",
                "cmtitle": "Category:" + categoryName,
                "list": "categorymembers",
                "cmlimit": "500"]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let JSON = object as? [String:AnyObject],
        let query = JSON["query"] as? [String:AnyObject],
        let categoryMembers = query["categorymembers"] as? Array<[String:AnyObject]> else {
            return nil
        }

        return try? decodeArray(categoryMembers) as [ProgrammingLanguage]
    }
}
