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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let camera = GMSCameraPosition.cameraWithLatitude(location.lat, longitude: location.lng, zoom: 10)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        mapView.myLocationEnabled = true
        view = mapView
        
        let position = CLLocationCoordinate2DMake(location.lat, location.lng)
        let marker = GMSMarker(position: position)
        marker.title = location.address
        marker.map = mapView
        
        guard let business = Business.businessArray else { return }
        self.addAnnotation(business, mapView: mapView)
        self.addOverlay(position, business: business, mapView: mapView)
    }
    
    func addAnnotation(business: [Business], mapView: GMSMapView) {
        for i in 0..<business.count {
            var place = business[i]
            var position = CLLocationCoordinate2DMake(Double(place.latitude), Double(place.longitude))
            var marker = GMSMarker(position: position)
            marker.title = place.name!
            marker.map = mapView
        }
        
        mapView.reloadInputViews()
    }
    
    func addOverlay(currentLocation: CLLocationCoordinate2D, business: [Business], mapView: GMSMapView) {
        let path = GMSMutablePath()
        path.addCoordinate(currentLocation)
        let firstRoute = GMSPolyline(path: path)
        firstRoute.map = mapView
        
        for i in 0..<business.count {
            var loc = business[i]
            var locPosition = CLLocationCoordinate2DMake(Double(loc.latitude), Double(loc.longitude))
            path.addCoordinate(locPosition)
            var route = GMSPolyline(path: path)
            route.map = mapView
        }
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
