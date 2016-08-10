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
import Alamofire
import SwiftyJSON

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
        self.addOverlayToMapView(position, business: business, mapView: mapView)
    }
    
    func addAnnotation(business: [Business], mapView: GMSMapView) {
        for i in 0..<business.count {
            let place = business[i]
            let position = CLLocationCoordinate2DMake(Double(place.latitude), Double(place.longitude))
            let marker = GMSMarker(position: position)
            marker.title = place.name!
            marker.map = mapView
        }
        
        mapView.reloadInputViews()
    }
    
    func addOverlayToMapView(currentLocation: CLLocationCoordinate2D, business: [Business], mapView: GMSMapView){
        
        for i in 0..<business.count {
            if i == 0 {
                let loc = business[i]
                print("--------------------------------------------------------------------------->>>>>>")
                print(loc.latitude)
                print(loc.longitude)
                let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLocation.latitude),\(currentLocation.longitude)&destination=\(loc.latitude),\(loc.longitude)&key=AIzaSyDhW5arAqiTATmGptRPs5G5s6uVKmrJO64"
                
                Alamofire.request(.GET, directionURL, parameters: nil).responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        
                        let json = JSON(data)
                        print(json)
                        let errornum = json["error"]
                        if (errornum == true){
                        }else{
                            let routes = json["routes"].array
                            if routes != nil{
                                let overViewPolyLine = routes![0]["overview_polyline"]["points"].string
                                print(overViewPolyLine)
                                if overViewPolyLine != nil{
                                    self.addPolyLineWithEncodedStringInMap(overViewPolyLine!, mapView: mapView)
                                }
                            }
                            
                        }
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
            } else {
                if i != business.count {
                    let loc1 = business[i-1]
                    let loc2 = business[i]
                    
                    let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(loc1.latitude),\(loc1.longitude)&destination=\(loc2.latitude),\(loc2.longitude)&key=AIzaSyDhW5arAqiTATmGptRPs5G5s6uVKmrJO64"
                    
                    Alamofire.request(.GET, directionURL, parameters: nil).responseJSON { response in
                        
                        switch response.result {
                            
                        case .Success(let data):
                            
                            let json = JSON(data)
                            print(json)
                            
                            let errornum = json["error"]
                            
                            
                            if (errornum == true){
                                
                            }else{
                                let routes = json["routes"].array
                                
                                if routes != nil{
                                    
                                    let overViewPolyLine = routes![0]["overview_polyline"]["points"].string
                                    print(overViewPolyLine)
                                    if overViewPolyLine != nil{
                                        self.addPolyLineWithEncodedStringInMap(overViewPolyLine!, mapView: mapView)
                                    }
                                    
                                }
                                
                                
                            }
                            
                        case .Failure(let error):
                            print("Request failed with error: \(error)")
                        }
                    }
                } else {
                    print("overlay finished")
                }
            }
            
        }
    }
    
    func addPolyLineWithEncodedStringInMap(encodedString: String, mapView: GMSMapView) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyLine = GMSPolyline(path: path)
        polyLine.strokeWidth = 5
        polyLine.strokeColor = UIColor.blueColor()
        polyLine.map = mapView
        
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
