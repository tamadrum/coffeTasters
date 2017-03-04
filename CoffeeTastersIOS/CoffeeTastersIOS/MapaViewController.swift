//
//  MapaViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class Pino: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinColor() -> UIColor  {
        if let location = locationName {
            switch location {
            case "Barista":
                return .green
            case "Cafeteria":
                return .purple
            default:
                return .red
            }
        }
        return .red
    }
}

class MapaViewController:UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapa: MKMapView!
    
    let initialLocation = CLLocation(latitude: -23.548064, longitude: -46.5708517)
    let regionRadius: CLLocationDistance = 500
    
    var locationManager = CLLocationManager()
    
    func setLocation(latitude: Double, longitude: Double) {
        
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapa.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(location: initialLocation)
        
        let pino = Pino(title: "Marco Polo",
                              locationName: "Caferetia",
                              subtitle: "Gelateria & Caffè",
                              coordinate: CLLocationCoordinate2D(latitude: -23.548064, longitude: -46.5708517))
        
        mapa.addAnnotation(pino)
    }
    
    func comprarItem(){
        let alertComprar = ComprarAlertViewController(controller: navigationController!)
        alertComprar.show("Comprando...", message: "Vamos gastar")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Pino {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
                view.pinTintColor = annotation.pinColor()
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Pino
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
}
