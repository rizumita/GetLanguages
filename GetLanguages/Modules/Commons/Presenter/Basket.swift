//
// Created by 和泉田 領一 on 2016/03/09.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import Swiftz

class Basket: NSObject, SourceType {
    // SourceType
    typealias Item = LanguageType
    var items: [LanguageType] = []
    let queue = dispatch_queue_create("jp.caph.GetLanguages.Basket.queue", DISPATCH_QUEUE_SERIAL)
}

extension Basket: UITableViewDataSource {
    func configureCell(cell: UITableViewCell, item: Item) {
        cell.textLabel?.text = item.name
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell
        = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.caughtLanguageCell.identifier, forIndexPath: indexPath)
        curry(configureCell) <^> cell <*> self[indexPath.row]
        return cell
    }
}
