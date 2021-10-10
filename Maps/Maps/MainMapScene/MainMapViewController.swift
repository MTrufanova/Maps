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

    var point: Point?
    
    private lazy var mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var pointInfoView = PointInfoView()
    
    private let locationManager = CLLocationManager()
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .online)
    private var searchSession: YMKSearchSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        pointInfoView.isHidden = true
        pointInfoView.confirmButton.addTarget(self, action: #selector(openDetailInfoPoint), for: .touchUpInside)
        createMapView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
    private func createMapView() {
        
        if let lat = locationManager.location?.coordinate.latitude,
           let long = locationManager.location?.coordinate.longitude {
            mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: lat, longitude: long), zoom: 16, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 3),
                cameraCallback: nil)
        }
        mapView.mapWindow.map.addInputListener(with: self)
        mapView.mapWindow.map.addTapListener(with: self)
    }
    
    @objc private func openDetailInfoPoint() {
        let infoPointVC = InfoPointViewController()
        infoPointVC.point = point
        infoPointVC.modalPresentationStyle = .formSheet
        navigationController?.present(infoPointVC, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        view.addSubview(mapView)
        mapView.addSubview(pointInfoView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pointInfoView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            pointInfoView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            pointInfoView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            pointInfoView.heightAnchor.constraint(equalToConstant: view.bounds.height/4)
        ])
    }
    
}


extension MainMapViewController: YMKMapInputListener {
    func onMapTap(with map: YMKMap, point: YMKPoint) {
//                let mapObjects = map.mapObjects
//                mapObjects.clear()
//                let placemark = mapObjects.addPlacemark(with: point)
//                placemark.setIconWith(Images.placemark)
//               let long = placemark.geometry.longitude
//                let lat = placemark.geometry.latitude
//                print("\(long)" + " " + " \(lat)")
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        
    }
    
    
}

extension MainMapViewController: YMKLayersGeoObjectTapListener {
    func onObjectTap(with event: YMKGeoObjectTapEvent) -> Bool {
        pointInfoView.isHidden = false
        pointInfoView.updateGeoposition(point: nil)
        let geoObject = event.geoObject
        
        guard let geoPosition = geoObject.geometry.first?.point else { return true }
        
        // MARK: - Ставит маячок по тапу
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        let placemark = mapObjects.addPlacemark(with: geoPosition)
        placemark.setIconWith(Images.placemark)
        
        let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                self.onSearchResponse(response)
            }
        }
        
        searchSession = searchManager.submit(with: geoPosition, zoom: 16, searchOptions: YMKSearchOptions(), responseHandler: responseHandler)
        
        return true
    }
    // MARK: - Получаем данные о точке
    func onSearchResponse(_ response: YMKSearchResponse) {
        guard let searchResult = response.collection.children.first else{ return }
        guard let obj = searchResult.obj else { return }
        guard let metadata =  obj.metadataContainer.getItemOf(YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata else { return }
        
        guard let country = obj.descriptionText,
              let postalCode = metadata.address.postalCode
        else { return }
        let countryPostal = "\(country), \(postalCode)"
        let lon = metadata.balloonPoint.longitude
        let lat = metadata.balloonPoint.latitude
        point = Point(address: obj.name, country: countryPostal, lat: lat, lon: lon)
        pointInfoView.updateGeoposition(point: point)
    }
    
    
}
