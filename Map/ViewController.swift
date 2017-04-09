//
//  ViewController.swift
//  Map
//
//  Created by BahaWooD on 19/03/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    //MARK: Properties
    @IBOutlet weak var mainMapView: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    @IBOutlet weak var clubLocationLabel: UILabel!
    //Properties.variables
    let regionRadius = 1000
    
    let locationManager = CLLocationManager()
    
    let sdu_location = CLLocationCoordinate2DMake(43.20786594848359, 76.66972160339355)
    
    //MARK: Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //Label which show distance
        distanceLabel.layer.cornerRadius = 25
        
        distanceLabel.layer.backgroundColor = UIColor(red: 201/255, green: 155/255, blue: 214/255, alpha: 1).cgColor
        
        //Work with map
        
        self.mainMapView.delegate = self
        
        self.mainMapView.mapType = .standard
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mainMapView.showsUserLocation = true
//        
        let annotation = Annotations(title: "Suleyman Demirel University", locationName: "Kaskelen, Abylai Khan 1", discipline: "University", coordinate: sdu_location)
        
        self.mainMapView.addAnnotation(annotation)
        
        centerMapOnLocation(location: sdu_location)

    }
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, CLLocationDistance(regionRadius * 2), CLLocationDistance(regionRadius * 2))
        
        mainMapView.setRegion(coordinateRegion, animated: true)
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        
//        let location = locations.last as! CLLocation
//        
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        self.mainMapView.setRegion(region, animated: true)
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mainMapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: localize description" + error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mainMapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                
            }
            return pinView;
        }
    }
    
}

