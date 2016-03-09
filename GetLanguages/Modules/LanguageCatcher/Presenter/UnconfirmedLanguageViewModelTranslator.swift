//
// Created by 和泉田 領一 on 2016/03/07.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit

class UnconfirmedLanguageViewModelTranslator: Translator<LanguageType, UnconfirmedLanguageViewModelType> {
    private let size: CGFloat
    private let actionDuration: NSTimeInterval

    init(size: CGFloat = 30.0, actionDuration: NSTimeInterval = 4.0) {
        self.size = size
        self.actionDuration = actionDuration
    }

    override func translate(source: Source) -> Destination {
        return UnconfirmedLanguageViewModel(language: source,
                                            positionMaker: RandomPositionMaker(),
                                            colorMaker: RandomColorMaker(),
                                            size: size,
                                            actionDuration: actionDuration)
    }
}
