//
//  ViewController.swift
//  Found
//
//  Created by Justin Vasselli on 4/25/16.
//  Copyright © 2016 Justin Vasselli. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationCoordinate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.setUserTrackingMode(.Follow, animated: true)
        
        locationCoordinate.text = "Latitude: \(mapView.userLocation.coordinate.latitude) & Longitude: \(mapView.userLocation.coordinate.longitude)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openAMap(sender: AnyObject) {
        if let url = NSURL(string: "http://maps.apple.com/?address=204,Barrows+Road,Brattleboro,Vermont") {
            let app = UIApplication.sharedApplication()
            app.openURL(url)
        }
    }

    @IBAction func addAPin(sender: AnyObject) {
        let action = UIAlertController(title: "Pin Annotation Modifier", message: "Name your own pin", preferredStyle: .Alert)
        action.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
            textField.placeholder = "Justin"
        }
        
        let namePinButton = UIAlertAction(title: "Name your Pin", style: .Default) {
            UIAlertAction -> Void in
            let textField = (action.textFields?.first)! as UITextField
            
            let pin = Pin(newLocation: self.mapView.userLocation.coordinate, withName: "\((textField.text)!)")
            self.mapView.addAnnotation(pin)
        }
        
        action.addAction(namePinButton)
        action.view.setNeedsLayout()
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    //For fun!!!
    //Use mapView.userLocation.coordinate.latitude / longitude to display latitud/longitude in the toolbar~
    //Display an alert to let the user name the pin
    //Add a way for user to share the location of a pin <-- Research!
}

