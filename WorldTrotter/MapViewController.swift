//
//  MapViewController.swift
//  WorldTrotter2
//
//  Created by Spencer Goff on 5/30/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /* Creates "show location" button */
        
        let showLocationButton: UIButton = UIButton(frame: CGRect(x: 20, y: 400, width: 50, height: 50))
        showLocationButton.layer.cornerRadius = 0.5 * showLocationButton.bounds.size.width
        showLocationButton.clipsToBounds = true
        showLocationButton.backgroundColor = UIColor.orange
        showLocationButton.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        showLocationButton.tag = 1
        self.view.addSubview(showLocationButton)
        
        /*let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myView)
        
        let margins = view.layoutMarginsGuide
        myView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        myView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 50) //the top of the view will be below the segmented view
        
        let zoomOnLocationButton: UIButton = UIButton()
        zoomOnLocationButton.setImage(UIImage(named: "LocationIcon"), for: .normal)
        zoomOnLocationButton.addTarget(self, action: #selector(zoomOnLocation), for: .touchUpInside)
        
        //zoomOnLocationButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        myView.addSubview(zoomOnLocationButton)
        //self.view.addSubview(zoomOnLocationButton)
        //zoomOnLocationButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        */
        
        
    }
    
    override func loadView() {
        mapView = MKMapView() //creates a map view
        view = mapView //sets the view to the map view
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")

        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])//this is the three-rectangle selector
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5) //alpha is transparency
        segmentedControl.selectedSegmentIndex = 0 //the last segment touched initially "Standard"
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(segControl:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false //turns off automatic constraints
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8) //the top of the segment will be below clock
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
    
    @IBAction func showLocation(_ sender: Any) {
        print("showLocation running")
        
        /* Tracks user location */
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) { //Check for Location Services
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        /* Shows dot at location of user */
        //var userLocation = CLLocation()
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(200, 200);
        mapView.addAnnotation(myAnnotation)
        //zoomOnLocation()
        
    }
    
    func zoomOnLocation() {
        print("zoomOnLocation running")
        /* Tracks user location */
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) { //Check for Location Services
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        //Zoom to user location
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        mapView.setRegion(viewRegion, animated: false)
        
        DispatchQueue.main.async {
            locationManager.startUpdatingLocation()
        }

    }
    
}





















