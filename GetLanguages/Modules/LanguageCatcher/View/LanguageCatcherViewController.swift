//
//  LanguageCatcherViewController.swift
//  GetLanguages
//
//  Created by 和泉田 領一 on 2016/03/06.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit

class LanguageCatcherViewController: UIViewController {
    
    var presenter: LanguageCatcherPresenterType!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.bringLanguages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
