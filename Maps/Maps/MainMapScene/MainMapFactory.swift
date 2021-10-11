//
//  MainMapFactory.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import Foundation
import UIKit

protocol MainMapFactoryProtocol {
 func configuredMainMapScene() -> UIViewController
}

class MainMapFactory: MainMapFactoryProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func configuredMainMapScene() -> UIViewController {
        let view = MainMapViewController()
        let router = MainMapRouter(navigationController: navigationController)
        let presenter = MainMapPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }


}
