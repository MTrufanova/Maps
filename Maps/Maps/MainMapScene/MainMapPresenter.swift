//
//  MainMapPresenter.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import Foundation

protocol MainMapPresenterProtocol: AnyObject {
    func presentPointVC(for point: Point?)
}

class MainMapPresenter: MainMapPresenterProtocol {

    weak var view: MainMapViewProtocol?
    private let router: MainMapRouterProtocol

    init(view: MainMapViewProtocol?, router: MainMapRouterProtocol) {
        self.view = view
        self.router = router
    }

    func presentPointVC(for point: Point?) {
        router.presentInfoPointVC(for: point)
    }
}
