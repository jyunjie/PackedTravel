//
//  MapViewController.swift
//  PackedTravel
//
//  Created by JJ on 05/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    var location = Location.currentLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.cameraWithLatitude(location.lat, longitude: location.lng, zoom: 20)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        mapView.myLocationEnabled = true
        view = mapView
        
        let position = CLLocationCoordinate2DMake(location.lat, location.lng)
        let marker = GMSMarker(position: position)
        marker.title = location.address
        marker.map = mapView
        
        guard let business = Business.businessArray else { return }
        self.addAnnotation(business, mapView: mapView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnnotation(business: [Business], mapView: GMSMapView) {
        for i in 0..<business.count {
            var place = business[i]
            var lat = CLLocationDegrees(place.latitude)
            var lng = CLLocationDegrees(place.longitude)
            var position = CLLocationCoordinate2DMake(lat, lng)
            var marker = GMSMarker(position: position)
            marker.map! = mapView
        }
        
        mapView.reloadInputViews()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
