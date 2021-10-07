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

extension MainMapViewController: YMKUserLocationObjectListener {

    func onObjectAdded(with view: YMKUserLocationView) {


    }

    func onObjectRemoved(with view: YMKUserLocationView) {

    }

    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {

    }


}
