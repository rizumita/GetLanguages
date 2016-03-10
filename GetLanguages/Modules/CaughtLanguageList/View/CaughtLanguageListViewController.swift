//
//  CaughtLanguageListViewController.swift
//  GetLanguages
//
//  Created by 和泉田 領一 on 2016/03/10.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import Swiftz

class CaughtLanguageListViewController: UITableViewController {

    var presenter: CaughtLanguageListPresenterType!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true

        tableView.dataSource = presenter.basket
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sendAction = curry(performSegueWithIdentifier) <^> R.segue.caughtLanguageListViewController.languageDetailSegue.identifier
        curry(presenter.showDetail) <^> indexPath.row <*> sendAction
    }

}
