//
//  InfoPointViewController.swift
//  Maps
//
//  Created by msc on 06.10.2021.
//

import UIKit

final class InfoPointViewController: UIViewController {

    var point: Point?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Местоположение"
        label.textColor = Colors.blackColor
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = createLabel(with: "Адрес")
    private lazy var latitudeLabel: UILabel = createLabel(with: "lat")
    private lazy var longitudeLabel: UILabel = createLabel(with: "lon")
    private lazy var addressTextField: UITextField = createTextField()
    private lazy var latitudeTextField: UITextField = createTextField()
    private lazy var longitudeTextField: UITextField = createTextField()
    private lazy var labelsStackView = UIStackView()
    private lazy var textFieldsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        createLabelsStack()
        createTextFieldsStack()
        fillFields()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }

    private func fillFields() {
        if let lat = point?.lat,
           let lon = point?.lon {
            latitudeTextField.text = String(format: "%.6f", lat)
            longitudeTextField.text = String(format: "%.6f", lon)
        }

        guard let country = point?.country,
              let address = point?.address else { return }
        addressTextField.text = "\(country), \(address)"
    }

    private func createLabelsStack() {
        labelsStackView = UIStackView(arrangedSubviews: [addressLabel, latitudeLabel, longitudeLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 42
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createTextFieldsStack() {
        textFieldsStackView = UIStackView(arrangedSubviews: [addressTextField, latitudeTextField, longitudeTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 16
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(labelsStackView)
        view.addSubview(textFieldsStackView)

        NSLayoutConstraint.activate([

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),

            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelsStackView.widthAnchor.constraint(equalToConstant: 70),
            labelsStackView.centerYAnchor.constraint(equalTo: textFieldsStackView.centerYAnchor),

            addressTextField.heightAnchor.constraint(equalToConstant: 44),
            latitudeTextField.heightAnchor.constraint(equalToConstant: 44),
            longitudeTextField.heightAnchor.constraint(equalToConstant: 44),

            textFieldsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 64),
            textFieldsStackView.leadingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: 8),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

}

extension InfoPointViewController {
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = Colors.blackColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.textColor = Colors.blackColor
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.textAlignment = .left
        textField.isUserInteractionEnabled = false
        textField.backgroundColor = Colors.viewsBlock
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
