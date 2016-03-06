//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit

struct RandomColorMaker: ColorMakerType{
    var color: UIColor {
        let number = arc4random_uniform(UInt32(colors.count))
        return colors[Int(number)]
    }
    private let colors: [UIColor] = [.greenColor(), .redColor(), .blueColor(), .grayColor(), .cyanColor(), .blackColor(), .brownColor()]
}
