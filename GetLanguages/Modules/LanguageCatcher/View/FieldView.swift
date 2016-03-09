//
// Created by 和泉田 領一 on 2016/03/06.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit

class FieldView: UIView {

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitted = subviews.flatMap {
            (view: UIView) -> UnconfirmedLanguageView? in
            switch view {
            case let result as UnconfirmedLanguageView:
                return result
            default:
                return nil
            }
        }.filter {
            $0.currentRect.contains(point)
        }.first

        return hitted ?? super.hitTest(point, withEvent: event)
    }

}
