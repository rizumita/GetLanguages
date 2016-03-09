//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
@testable import GetLanguages

struct StaticColorMaker: ColorMakerType{
    var color: UIColor {
        return UIColor.redColor()
    }
}
