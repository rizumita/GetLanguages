//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

class Basket {
    let addObserver: Observer<LanguageType, NoError>
    private let addSignal: Signal<LanguageType, NoError>

    private var scheduler: QueueScheduler
    private var queue                     = dispatch_queue_create("jp.caph.GetLanguages.Basket.queue", DISPATCH_QUEUE_SERIAL)
    private var store:     [LanguageType] = []

    init() {
        (addSignal, addObserver) = Signal.pipe()
        scheduler = QueueScheduler(queue: queue)

        addSignal.observeOn(scheduler).observeNext {
            [weak self] in
            self?.store.append($0)
        }
    }

    subscript(index: Int) -> LanguageType? {
        var result: LanguageType?

        dispatch_sync(queue) {
            [weak self] in
            if index < self?.store.count {
                result = self?.store[index]
            }
        }

        return result
    }

    var count: Int {
        return store.count
    }

}
