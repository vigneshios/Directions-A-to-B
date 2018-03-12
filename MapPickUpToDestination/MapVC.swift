//
//  ViewController.swift
//  MapPickUpToDestination
//
//  Created by Apple on 12/03/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    // Outlets:
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        drawRoutes()
        
    }
    
    func drawRoutes() {
        
        let pickupCoordinate = CLLocationCoordinate2D(latitude: 36.169941, longitude: -115.139830)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 36.174327, longitude: -115.145323)
        
        let pickupPin = CustomPinAnnotation(coordinate: pickupCoordinate, title: "Las Vegas", subTitle: "SinCity")
        let destinationPin = CustomPinAnnotation(coordinate: destinationCoordinate, title: "Casino Brewery Hotel", subTitle: "Casino Royale")
        
        self.mapView.addAnnotation(pickupPin)
        self.mapView.addAnnotation(destinationPin)
        
        let pickupPlacemark = MKPlacemark(coordinate: pickupCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: pickupPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (res, err) in
            guard let directionResponse = res else {
                if let err = err {
                    print("Error in getting directions == \(err.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        renderer.lineWidth = 2.5
        return renderer
    }
    
}

