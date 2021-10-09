//
//  InfoPointViewController.swift
//  Maps
//
//  Created by msc on 06.10.2021.
//

import UIKit

final class InfoPointViewController: UIViewController {
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 20
        textField.backgroundColor = Colors.viewsBlock
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(addressLabel)
        view.addSubview(addressTextField)
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressLabel.centerYAnchor.constraint(equalTo: addressTextField.centerYAnchor),
            addressLabel.widthAnchor.constraint(equalToConstant: 70),
            
            addressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
            addressTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addressTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
