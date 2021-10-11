//
//  MainMapRouter.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import UIKit

protocol MainMapRouterProtocol {
    func presentInfoPointVC(for point: Point?)
}

final class MainMapRouter: MainMapRouterProtocol {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func presentInfoPointVC(for point: Point?) {
        if (navigationController?.topViewController as? InfoPointViewProtocol) != nil {
            return
        } else {
            let pointVC = InfoPointFactory.configuredPointVC(for: point)
            pointVC.modalPresentationStyle = .formSheet
            navigationController?.present(pointVC, animated: true, completion: nil)

        }
    }

}
