//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit

struct RandomPositionMaker: PositionMakerType {

    func positionOnArea(area: CGSize) -> CGPoint {
        let x = arc4random_uniform(UInt32(area.width))
        let y = arc4random_uniform(UInt32(area.height))
        let destination = CGPoint(x: CGFloat(x), y: CGFloat(y))
        return destination
    }

}
