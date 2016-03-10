//
//  LanguageDetailViewController.swift
//  GetLanguages
//
//  Created by 和泉田 領一 on 2016/03/10.
//  Copyright © 2016年 CAPH. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LanguageDetailViewController: UIViewController {
    var presenter: LanguageDetailPresenterType!

    @IBOutlet weak var webView: UIWebView!

    private let disposable = CompositeDisposable()
    private var scopedDisposable: ScopedDisposable?

    override func viewDidLoad() {
        super.viewDidLoad()

        scopedDisposable = ScopedDisposable(disposable)
        disposable += presenter.contentProperty.producer.ignoreNil().startWithNext {
            [weak self] in self?.loadContent($0)
        }

        presenter.fetchContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadContent(content: String) {
        webView.loadHTMLString(content, baseURL: NSURL(string: "http://ja.wikipedia.org"))
    }
}
