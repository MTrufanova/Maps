//
//  StartScenePresenter.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import Foundation

protocol StartPresenterProtocol: AnyObject {
    func pushMapVC()
}

class StartPresenter: StartPresenterProtocol {

    weak var view: StartViewProtocol?
    private let router: StartRouterProtocol

    init(view: StartViewProtocol?, router: StartRouterProtocol) {
        self.view = view
        self.router = router
    }

    func pushMapVC() {
        router.pushMap()
    }
}
