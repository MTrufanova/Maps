//
//  StartSceneFactory.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import UIKit

protocol StartSceneFactoryProtocol {
     func configuredStartScene() -> UIViewController
}

final class StartSceneFactory: StartSceneFactoryProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

     func configuredStartScene() -> UIViewController {
        let view = StartViewController()
        let router = StartRouter(navigationController: navigationController)
        let presenter = StartPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

}
