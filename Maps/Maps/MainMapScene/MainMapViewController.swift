//
//  MainMapViewController.swift
//  Maps
//
//  Created by msc on 06.10.2021.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class MainMapViewController: UIViewController {

    private lazy var mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        createMapView()
        setupLayout()

    }
    
    private func createMapView() {

        if let lat = locationManager.location?.coordinate.latitude,
           let long = locationManager.location?.coordinate.longitude {
            mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: lat, longitude: long), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
        }
        mapView.mapWindow.map.addInputListener(with: self)
    }

    private func setupLayout() {
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}


extension MainMapViewController: YMKMapInputListener {
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        let mapObjects = map.mapObjects
        mapObjects.clear()
        let placemark = mapObjects.addPlacemark(with: point)
        placemark.setIconWith(Images.placemark)
    }

    func onMapLongTap(with map: YMKMap, point: YMKPoint) {

    }


}


