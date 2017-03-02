import Foundation
import MapKit
import Contacts

class Pino: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let tipo: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, tipo: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.tipo = tipo
        
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
        switch tipo {
        case "Cafeteria", "Barista":
            return .purple
        case "Café", "Chá":
            return .red
        default:
            return .green
        }
    }
}
