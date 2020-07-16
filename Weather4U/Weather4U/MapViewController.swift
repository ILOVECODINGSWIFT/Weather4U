//
//  ViewController.swift
//  Weather4U
//
//  Created by iLoveSwift on 16/07/20.
//  Copyright © 2020 ILoveCodingSwift. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {

    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. com.ilovecodingswift.Weather4U
        
        mapView.delegate = self
        mapView.showsUserLocation = true

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
          let doubleTapG = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(gestureRecognizer:)))
          doubleTapG.numberOfTapsRequired = 2
          self.mapView.addGestureRecognizer(doubleTapG)
    }
        
    @objc func handleSingleTap(gestureRecognizer: UILongPressGestureRecognizer) {

        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let vc = CurrentWeatherViewController.create(lat: "\(coordinate.latitude)", lng: "\(coordinate.longitude)")
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if currentLocation == nil
        {
            if let userLocation = locations.last {
            
                let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

                self.mapView.setRegion(region, animated: true)
                
                currentLocation = locations.last
            }
        }
    }
    
}

