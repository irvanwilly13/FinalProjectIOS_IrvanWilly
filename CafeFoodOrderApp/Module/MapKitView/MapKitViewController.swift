//
//  MapKitViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 01/11/24.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift

class MapKitViewController: BaseViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapkitView: MKMapView!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
//    func setupView() {
//        searchButton.rx.tap.subscribe() { [weak self]
//            
//        }.disposed(by: DisposeBag)
//    }
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapkitView.delegate = self
        
        
    }
}

extension MapKitViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapkitView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension MapKitViewController: UITextFieldDelegate {
    
}
extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
}
