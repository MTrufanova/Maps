//
//  InfoPointFactory.swift
//  Maps
//
//  Created by msc on 11.10.2021.
//

import UIKit

protocol InfoPointFactoryProtocol {
    static func configuredPointVC(for point: Point?) -> UIViewController
}

class InfoPointFactory: InfoPointFactoryProtocol {
    static func configuredPointVC(for point: Point?) -> UIViewController {
        let view = InfoPointViewController()
        let presenter = InfoPointPresenter(view: view, point: point)
        view.presenter = presenter
        return view
    }


}
