//
//  DetalhesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
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

class DetalhesViewController:UIViewController, MKMapViewDelegate{
    
    var cafeAvaliado: Cafe?
    
    @IBOutlet var torradorLabel: UILabel?
    @IBOutlet var produtorLabel: UILabel?
    
    @IBOutlet var altitudeLabel: UILabel?
    @IBOutlet var cidadeLabel: UILabel?
    @IBOutlet var estadoLabel: UILabel?
    @IBOutlet var paisLabel: UILabel?
    @IBOutlet var regiaoLabel: UILabel?
    @IBOutlet var safraLabel: UILabel?
    @IBOutlet var tipoLabel: UILabel?
    @IBOutlet var imageImage: UIImageView?
    
    @IBOutlet var mapaMapView: MKMapView?
    
    @IBOutlet var descricaoTextView: UITextView?
    @IBOutlet var rodaWheelFlavor: WheelFlavor?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = cafeAvaliado?.nome
        
        torradorLabel?.text = cafeAvaliado?.torrador
        produtorLabel?.text = cafeAvaliado?.produtor
        paisLabel?.text = cafeAvaliado?.pais
        cidadeLabel?.text = cafeAvaliado?.cidade
        estadoLabel?.text = cafeAvaliado?.estado
        tipoLabel?.text = cafeAvaliado?.tipo
        altitudeLabel?.text = "\((cafeAvaliado?.altitude)!)"
        safraLabel?.text = "\(cafeAvaliado?.safra)"

        centerMapOnLocation(location: initialLocation)
        
        let pino = Pino(title: "Marco Polo",
                        locationName: "Caferetia",
                        subtitle: "Gelateria & Caffè",
                        coordinate: CLLocationCoordinate2D(latitude: -23.548064, longitude: -46.5708517))
        
        mapaMapView?.addAnnotation(pino)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "telaAvalia") {
            let view = segue.destination as! AvaliacaoViewController
            view.cafeAvaliado(cafeAvaliado!)
        }
    }
    
    // Coisas do Mapa
    
    let initialLocation = CLLocation(latitude: -23.548064, longitude: -46.5708517)
    let regionRadius: CLLocationDistance = 500
    
    var locationManager = CLLocationManager()
    
    func cafeAvaliado(_ cafe: Cafe) {
        cafeAvaliado = cafe
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapaMapView?.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapaMapView?.setRegion(coordinateRegion, animated: true)
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
