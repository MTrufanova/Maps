//
//  InfoPointPresenter.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import Foundation

protocol InfoPointPresenterProtocol: AnyObject {
   func presentPointInfo()
}

class InfoPointPresenter: InfoPointPresenterProtocol {
    var point: Point?
    weak var view: InfoPointViewProtocol?

    init(view: InfoPointViewProtocol, point: Point?) {
        self.view = view
        self.point = point
    }
    func presentPointInfo() {
        view?.showPoint(for: point)
    }
}
