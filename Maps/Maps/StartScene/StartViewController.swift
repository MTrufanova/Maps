//
//  ViewController.swift
//  Maps
//
//  Created by msc on 06.10.2021.
//

import UIKit

class StartViewController: UIViewController {

   private lazy var showMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать на карте", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
       button.setTitleColor(Colors.blue, for: .normal)
        button.addTarget(self, action: #selector(showMapAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Colors.background
        setupLayout()
    }

    @objc private func showMapAction() {
        let mainMapVC = MainMapViewController()
        navigationController?.pushViewController(mainMapVC, animated: true)
    }

    private func setupLayout() {
        view.addSubview(showMapButton)

        NSLayoutConstraint.activate([
            showMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showMapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

