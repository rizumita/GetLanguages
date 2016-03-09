//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
@testable import GetLanguages

class StaticPositionMaker: PositionMakerType {
    func positionOnArea(area: CGSize) -> CGPoint {
        if positions.count > 0 {
            return positions.removeFirst()
        } else {
            return CGPointZero
        }
    }

    private var positions: [CGPoint]

    init(positions: [CGPoint]) {
        self.positions = positions
    }
}
