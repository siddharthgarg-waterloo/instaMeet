//
//  MainMapViewController.swift
//  instaMeet
//
//  Created by Siddharth on 12/10/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    let request = MKLocalSearch.Request()
    let locationPin = MKPointAnnotation()
    @IBOutlet weak var meetUpinformation: UIView!
    
    @IBAction func goToHomeViewController(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.image = image
        homeVC.needToPresentSentimentPopUp = true
        present(homeVC, animated: true, completion: nil)
    }
    
    var address: String = ""
    var name: String = ""
    var image: UIImage? = nil
    var lat: Double = 0
    var long: Double = 0
    
    @IBOutlet weak var addressPlace: UILabel!
    @IBOutlet weak var namePlace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        namePlace.text = name
        addressPlace.text = address
        
        mapView.showsUserLocation = true
        request.naturalLanguageQuery = address
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if let results = response {
                if let err = error {
                    print("Error occurred in search: \(err.localizedDescription)")
                } else if results.mapItems.count == 0 {
                    print("No matches found")
                } else {
                    print("Matches found")
                    if let location = results.mapItems.first {
                        self.locationPin.coordinate = location.placemark.coordinate
                        self.mapView.addAnnotation(self.locationPin)
                        
                        let request: MKDirections.Request = MKDirections.Request()
                        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: self.lat)!, longitude: CLLocationDegrees(exactly: self.long)!)))
                        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.locationManager.location!.coordinate))
                        request.transportType = .automobile
                        
                        let directions = MKDirections(request: request)
                            directions.calculate { (response, error) in
                                guard let directionResonse = response else {
                                    if let error = error {
                                        print("we have error getting directions==\(error.localizedDescription)")
                                    }
                                    return
                                }
                                
                                //get route and assign to our route variable
                                let route = directionResonse.routes[0]
                                
                                //add rout to our mapview
                                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                                
                                //setting rect of our mapview to fit the two locations
                                let rect = route.polyline.boundingMapRect
                                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                            }
  
                    }
                }
            }
        })
        meetUpinformation.layer.cornerRadius = 30
        meetUpinformation.layer.masksToBounds = true
        
        self.mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        }
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red:0.00, green:0.65, blue:1.00, alpha:1.0)
        renderer.lineWidth = 4.0
        return renderer
    }
}
