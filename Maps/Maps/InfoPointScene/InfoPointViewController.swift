//
//  InfoPointViewController.swift
//  Maps
//
//  Created by msc on 06.10.2021.
//

import UIKit

protocol InfoPointViewProtocol: AnyObject {
    func showPoint(for point: Point?)
}

final class InfoPointViewController: UIViewController {

    var point: Point?
    
    var presenter: InfoPointPresenterProtocol?

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

    private lazy var addressTextView: UITextView = {
        let textView = UITextView()
        textView.sizeToFit()
        textView.textColor = Colors.blackColor
        textView.font = .systemFont(ofSize: 16, weight: .semibold)
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 5
        textView.backgroundColor = Colors.viewsBlock
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var latitudeTextField: UITextField = createTextField()
    private lazy var longitudeTextField: UITextField = createTextField()
    private lazy var labelsStackView = UIStackView()
    private lazy var textFieldsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        presenter?.presentPointInfo()
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
        addressTextView.text = "\(country), \(address)"
    }

    private func createLabelsStack() {
        labelsStackView = UIStackView(arrangedSubviews: [addressLabel, latitudeLabel, longitudeLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 52
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createTextFieldsStack() {
        textFieldsStackView = UIStackView(arrangedSubviews: [addressTextView, latitudeTextField, longitudeTextField])
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

extension InfoPointViewController: InfoPointViewProtocol {
    func showPoint(for point: Point?) {
        self.point = point
    }

    
}
