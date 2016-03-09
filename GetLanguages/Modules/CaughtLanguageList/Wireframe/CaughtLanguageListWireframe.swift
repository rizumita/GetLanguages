//
// Created by 和泉田 領一 on 2016/03/10.
// Copyright (c) 2016 CAPH. All rights reserved.
//

import UIKit

class CaughtLanguageListWireframe {

    let presenter: CaughtLanguageListPresenterType
    var viewController: UIViewController?

    init(presenter: CaughtLanguageListPresenterType) {
        self.presenter = presenter
    }

    func showWithBasket(basket: Basket) {
        presenter.basket = basket
    }

}
