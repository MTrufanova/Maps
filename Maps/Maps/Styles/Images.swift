//
//  Images.swift
//  Maps
//
//  Created by msc on 08.10.2021.
//

import UIKit

private let largeConfig = UIImage.SymbolConfiguration(textStyle: .title2)
enum Images {
    static let placemark = UIImage(named: "placemark") ?? UIImage()
    static let closeImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig)?.withTintColor(Colors.grayColor ?? .gray, renderingMode: .alwaysOriginal)
}
