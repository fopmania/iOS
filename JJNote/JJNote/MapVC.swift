//
//  MapVC.swift
//  JJNote
//
//  Created by MAC on 2017-04-10.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    let LM = CLLocationManager()
    var lat = 36.699255
    var lon = 127.792969
    var disc = ""
    var pin: JunAnnotation? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.LM.delegate = self
        self.LM.desiredAccuracy = kCLLocationAccuracyBest
        self.LM.requestWhenInUseAuthorization()
        self.LM.startUpdatingLocation()
        
        self.map.showsUserLocation = true
        goPin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goPin(){
        let distanceSpan:CLLocationDegrees = 20000
        
        let loc :CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        self.map.setRegion(MKCoordinateRegionMakeWithDistance(loc, distanceSpan, distanceSpan), animated: true)
        pin = JunAnnotation(title: "Pic Pin", subtitle: disc, coordinate: loc);
        self.map.selectedAnnotations = [pin!]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
