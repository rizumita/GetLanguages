//
// Created by 和泉田 領一 on 2016/03/08.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import APIKit

protocol WikipediaRequestType: RequestType {
}

extension WikipediaRequestType {
    var baseURL: NSURL {
        return NSURL(string: "http://ja.wikipedia.org")!
    }

    var path: String {
        return "/w/api.php"
    }
}
