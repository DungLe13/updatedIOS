//
//  ViewController.swift
//  MapLocator
//
//  Created by Student on 4/18/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(_ placemark: MKPlacemark)
}

class ViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var searchController: UISearchController!
    var annotation: MKAnnotation!
    
    var locationManager: CLLocationManager!
    
    var selectedPin: MKPlacemark? = nil
    var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        view.backgroundColor = UIColor.gray
        mapView.setUserTrackingMode(.follow, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSearchBar(_ sender: AnyObject) {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        searchController = UISearchController(searchResultsController: locationSearchTable)
        searchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchController?.searchBar
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    // FUNCTIONS for USING FILTER & LOCAL SEARCH
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Types Segue" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! TypesTableViewController
            controller.selectedTypes = searchedTypes
            controller.delegate = self
        }
    }
    
    func filterNearbyPlaces() {
        matchingItems.removeAll()
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchedTypes[0]
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            for item in response.mapItems {
                self.matchingItems.append(item as MKMapItem)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    // FUNCTIONS for SHOWING THE ADDRESS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(locationManager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.addressLabel.text = "\(pm.locality), \(pm.country)"
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func writeReview(_ sender: UIButton) {
        let review = self.storyboard?.instantiateViewController(withIdentifier: "review") as! UINavigationController
        self.present(review, animated: true, completion: nil)
    }
    
    // FUNCTIONS for CHANGING PIN ANNOTATION VIEW
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pinDetailView"
        
        if annotation.isKind(of: MKPointAnnotation.self) {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
                btn.backgroundColor = UIColor.red
                btn.setTitle("REVIEW", for: UIControlState())
                btn.titleLabel!.textColor = UIColor.red
                btn.titleLabel!.textAlignment = .center
                btn.titleLabel?.font = .systemFont(ofSize: 20)
                btn.addTarget(self, action: #selector(ViewController.writeReview(_:)), for: .touchUpInside)
         
                let rating = CosmosView()
                rating.settings.updateOnTouch = false
                rating.settings.fillMode = .precise
                rating.settings.emptyBorderColor = UIColor.cyan
                
                let numberOfReview = UILabel()
                numberOfReview.text = "(0 reviews)"
                
                annotationView!.rightCalloutAccessoryView = btn
                annotationView!.detailCalloutAccessoryView = rating
                //annotationView!.detailCalloutAccessoryView = numberOfReview
            } else {
                annotationView!.annotation = annotation
            }
        
            return annotationView
        }
        return nil
    }
    
    // FUNCTIONS for CENTERING searched results
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapWhenSearched(_ location: MKPointAnnotation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark){
        selectedPin = placemark

        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }

        mapView.addAnnotation(annotation)
        
        centerMapWhenSearched(annotation)
    }
}

extension ViewController: TypesTableViewControllerDelegate {
    func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String]) {
        searchedTypes = controller.selectedTypes.sorted()
        dismiss(animated: true, completion: nil)
        self.filterNearbyPlaces()
    }
}












