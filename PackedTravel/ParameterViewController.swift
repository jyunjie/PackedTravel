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
    
    @IBOutlet var searchBtn: UIButton!
    
    var selectedLocation: Location!
    let leftImageView = UIImageView()
    let leftImageView2 = UIImageView()
    @IBOutlet var distanceTxtFld: UITextField!
    @IBOutlet var locationTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "750_1334")!)
//        self.searchBtn.layer.borderWidth = 0.5
        self.searchBtn.layer.cornerRadius = 5
//        self.searchBtn.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.distanceTxtFld.underlineforTextField()
        self.locationTxtFld.underlineforTextField()
        
        let leftView = UIView()
        leftView.addSubview(leftImageView)
        leftView.frame = CGRectMake(0, 0, 30, 20)
        leftImageView.frame = CGRectMake(0, 0, 20, 20)
        leftImageView.image = UIImage(named: "globe_asia-25");
        locationTxtFld.leftView = leftView;
        locationTxtFld.leftViewMode = UITextFieldViewMode.Always
        
        let leftView2 = UIView()
        leftView2.addSubview(leftImageView2)
        leftView2.frame = CGRectMake(0, 0, 30, 20)
        leftImageView2.frame = CGRectMake(0, 0, 20, 20)
        leftImageView2.image = UIImage(named: "near_me-25");
        distanceTxtFld.leftView = leftView2;
        distanceTxtFld.leftViewMode = UITextFieldViewMode.Always
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
        Business.searchWithTerm("", sort: nil , categories:["amusementparks","waterparks","gardens","hot_air_balloons","aquariums","festivals"] , deals: nil, radius_filter: Int(distanceTxtFld.text!)! * 1000,longitude: CGFloat(selectedLocation.lat),latitude:CGFloat(selectedLocation.lng), completion: { (businesses:[Business]!, error: NSError!) -> Void in
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
        
        spinnerActivity.label.text = "Searching for places..";
        
        spinnerActivity.userInteractionEnabled = false;
        getLocation(locationTxtFld.text!)
    }
    
    
    func findSecondHalf(completionHandler:() -> ()) {
        Business.searchWithTerm("", sort: nil , categories:["museums","fleamarkets","tours","fireworks","localflavor","nightlife"], deals: nil, radius_filter: Int(distanceTxtFld.text!)! * 1000, longitude: CGFloat(selectedLocation.lat) ,latitude:CGFloat(selectedLocation.lng) ,completion: { (businesses:[Business]!, error: NSError!) -> Void in
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
        }else{
            newString = location
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
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
}

extension UITextField {
    
    func underlineforTextField() {
        
        let bottomborder = CALayer()
        let WidthforBorder = CGFloat(1.0)
        bottomborder.borderColor = UIColor.blackColor().CGColor // customize the color
        bottomborder.frame = CGRectMake(0, self.frame.size.height - WidthforBorder, self.frame.size.width, self.frame.size.height)
        bottomborder.borderWidth = WidthforBorder
        self.layer.addSublayer(bottomborder)
        self.layer.masksToBounds = true
    }
}

