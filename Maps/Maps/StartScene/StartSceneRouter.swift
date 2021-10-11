//
//  StartSceneRouter.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import UIKit

protocol StartRouterProtocol {
    func pushMap()
}

final class StartRouter: StartRouterProtocol {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func pushMap() {
        if (navigationController?.topViewController as? MainMapViewProtocol) != nil {
            return
        } else {
            let mainMapFactory = MainMapFactory(navigationController: navigationController ?? UINavigationController())
            let mainMapVC = mainMapFactory.configuredMainMapScene()
            navigationController?.pushViewController(mainMapVC, animated: true)

        }
    }

}
