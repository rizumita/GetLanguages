//
//  LanguageCatcherViewController.swift
//  GetLanguages
//
//  Created by 和泉田 領一 on 2016/03/06.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LanguageCatcherViewController: UIViewController {

    let maxLanguageNumber = 5
    
    @IBOutlet weak var fieldView: FieldView!
    
    var presenter: LanguageCatcherPresenterType!

    let disposable = CompositeDisposable()

    override func viewDidLoad() {
        super.viewDidLoad()

        disposable += presenter.languageViewModelProperty.producer.ignoreNil().observeOn(UIScheduler()).startWithNext(bringLanguageView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        for _ in 0..<(maxLanguageNumber - fieldView.subviews.count) {
            presenter.bringLanguages()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bringLanguageView(viewModel: UnconfirmedLanguageViewModel) {
        let languageView = UnconfirmedLanguageView(viewModel: viewModel)
        languageView.emergeOnField(fieldView)
        languageView.move()
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
