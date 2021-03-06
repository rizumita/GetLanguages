//
//  LanguageCatcherViewController.swift
//  GetLanguages
//
//  Created by 和泉田 領一 on 2016/03/06.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import Rex

class LanguageCatcherViewController: UIViewController {

    var maxLanguageNumber: Int = 10

    @IBOutlet weak var fieldView: FieldView!

    var presenter: LanguageCatcherPresenterType!

    private let needsLanguageSignalAndObserver: (Signal<(), NoError>, Observer<(), NoError>) = Signal.pipe()
    private let disposable                                                                   = CompositeDisposable()
    private var scopedDisposable:               ScopedDisposable?

    var isPresenting = false

    override func viewDidLoad() {
        super.viewDidLoad()

        let skipWhile = {
            [unowned self] in self.presenter.preparedProperty.value == false
        }
        disposable += needsLanguageSignalAndObserver.0.skipWhile(skipWhile).observeNext {
            [weak self] in self?.presenter.bringLanguage($0)
        }
        disposable += presenter.languageViewModelSignal.observeOn(UIScheduler()).observeNext {
            [weak self] in self?.bringLanguageView($0)
        }
        disposable += QueueScheduler().scheduleAfter(NSDate(), repeatingEvery: 3.0) {
            [unowned self] in
            if self.isPresenting == true && self.fieldView.subviews.count < self.maxLanguageNumber {
                self.needsLanguageSignalAndObserver.1.sendNext()
            }
        }
        scopedDisposable = ScopedDisposable(disposable)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        fieldView.languageViews.forEach {
            $0.move()
        }

        isPresenting = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        isPresenting = false

        fieldView.languageViews.forEach {
            $0.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bringLanguageView(viewModel: UnconfirmedLanguageViewModelType) {
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
