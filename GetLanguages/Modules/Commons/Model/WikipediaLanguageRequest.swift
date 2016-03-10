//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import APIKit

struct WikipediaLanguageRequest: WikipediaRequestType {
    typealias Response = String

    var id: Int = 0

    var method: HTTPMethod {
        return .GET
    }

    var parameters: [String:AnyObject] {
        return ["format": "json",
                "action": "query",
                "prop": "revisions",
                "pageids": id,
                "rvprop": "content",
                "rvparse": ""]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let JSON = object as? [String:AnyObject],
        let query = JSON["query"] as? [String:AnyObject],
        let pages = query["pages"] as? [String:AnyObject],
        let language = pages["\(id)"] as? [String:AnyObject],
        let revisions = language["revisions"] as? [[String:AnyObject]]
        where revisions.count > 0,
        let content = revisions[0]["*"] as? String else {
            return nil
        }

        return content
    }
}
