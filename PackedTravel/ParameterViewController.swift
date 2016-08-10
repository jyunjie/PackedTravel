//
//  ViewController.swift
//  PackedTravel
//
//  Created by JJ on 05/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ParameterViewController: UIViewController {
    var businesses = [Business]()
    
    var selectedLocation: Location!
    @IBOutlet var distanceTxtFld: UITextField!
    @IBOutlet var locationTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        findFirstHalf()  // hard corded, remove this when insert realtime location
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ParameterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    


func dismissKeyboard() {
    view.endEditing(true)
}

    func findFirstHalf() {
        print(Int(distanceTxtFld.text!)! * 1000)
        print(CGFloat(selectedLocation.lng))
        print(CGFloat(selectedLocation.lat))
        Business.searchWithTerm("", sort:.HighestRated , categories:["amusementparks","waterparks","gardens","hot_air_balloons","aquariums","festivals"] , deals: nil, radius_filter: Int(distanceTxtFld.text!)! * 1000,longitude: CGFloat(selectedLocation.lat),latitude:CGFloat(selectedLocation.lng), completion: { (businesses:[Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            for business in businesses {
                self.businesses.append(business)
                print(business.name!)
                print(business.latitude)
                print(business.longitude)
                
            }
            
            print(self.businesses.count)
            self.findSecondHalf {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.performSegueWithIdentifier("placeSegue", sender: self)
            }
        })

    }

    @IBAction func searchBtnOnClicked(sender: UIButton) {
        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        spinnerActivity.label.text = "Logging in, please wait..";
        
        spinnerActivity.userInteractionEnabled = false;
        getLocation(locationTxtFld.text!)
    }
    
    
    func findSecondHalf(completionHandler:() -> ()) {
        Business.searchWithTerm("", sort: .HighestRated , categories:["museums","fleamarkets","tours","fireworks","localflavor"], deals: nil, radius_filter: Int(distanceTxtFld.text!)! * 1000, longitude: CGFloat(selectedLocation.lat) ,latitude:CGFloat(selectedLocation.lng) ,completion: { (businesses:[Business]!, error: NSError!) -> Void in
            for business in businesses {
                self.businesses.append(business)
                print(business.name!)
            }
            completionHandler()
        })
        
        

       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "placeSegue"{
        let tabCtrl = segue.destinationViewController as! UITabBarController
        let navVc = tabCtrl.viewControllers?.first as! UINavigationController
        let destVc = navVc.viewControllers[0] as! PlacesViewController
        destVc.businesses = self.businesses
        }
        
    }
    
    func getLocation (location: String) {
        var newString: String!
        if location.containsString(" ") {
            newString = location.stringByReplacingOccurrencesOfString(" ", withString: "+")
        }
        
        Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/geocode/json?address=\(newString)&key=AIzaSyDhW5arAqiTATmGptRPs5G5s6uVKmrJO64")
            .responseJSON { (response) in
                switch response.result {
                case.Success(let responseValue):
                    let json = JSON(responseValue)
                    self.selectedLocation = Location(json: json)
                    print(self.selectedLocation.lat)
                    print(self.selectedLocation.lng)
                    print(self.selectedLocation.address)
                    Location.currentLocation = self.selectedLocation
                    self.findFirstHalf()
                    case.Failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}


