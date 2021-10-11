//
//  PointInfoView.swift
//  Maps
//
//  Created by msc on 08.10.2021.
//

import UIKit

class PointInfoView: UIView {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.closeImage, for: .normal)
        button.addTarget(self, action: #selector(closePointIfoViewAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lineIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.blackColor
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryCityLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.grayColor
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coordinateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.blackColor
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.background
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    
    @objc private func closePointIfoViewAction() {
        self.isHidden = true
    }
    
    
    func updateGeoposition(point: Point?) {
        guard let lat = point?.lat, let lon = point?.lon else {
            coordinateLabel.text = " "
            return }
        let latString = String(format: "%.6f", lat)
        let lonString = String(format: "%.6f", lon)
        coordinateLabel.text = "\(latString), \(lonString)"
        addressLabel.text = point?.address
        guard let country = point?.country, let postalCode = point?.postalCode
        else {
            countryCityLabel.text = point?.country
            return}
        countryCityLabel.text = "\(country), \(postalCode)"
    }
    
    private func setupLayout() {
        addSubview(closeButton)
        addSubview(lineIndicatorView)
        addSubview(addressLabel)
        addSubview(countryCityLabel)
        addSubview(coordinateLabel)
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 54),
            closeButton.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            lineIndicatorView.widthAnchor.constraint(equalToConstant: 30),
            lineIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            lineIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineIndicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            
            countryCityLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            countryCityLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            countryCityLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            
            coordinateLabel.topAnchor.constraint(equalTo: countryCityLabel.bottomAnchor, constant: 8),
            coordinateLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            coordinateLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            confirmButton.widthAnchor.constraint(equalToConstant: 130),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
