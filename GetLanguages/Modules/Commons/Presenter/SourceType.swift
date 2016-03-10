//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

protocol SourceType: class {
    typealias Item
    var items: [Item] { get set }
    var count: Int { get }
    var queue: dispatch_queue_t! { get }

    func addItem(item: Item)

    subscript(index: Int) -> Item? { get }
}

extension SourceType {
    var count: Int {
        return items.count
    }

    func addItem(item: Item) {
        dispatch_sync(queue) {
            self.items.append(item)
        }
    }

    subscript(index: Int) -> Item? {
        var result: Item?

        dispatch_sync(queue) {
            if index < self.items.count {
                result = self.items[index]
            }
        }

        return result
    }
}
