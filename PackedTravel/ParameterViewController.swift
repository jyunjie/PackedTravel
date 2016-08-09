//
//  ViewController.swift
//  PackedTravel
//
//  Created by JJ on 05/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class ParameterViewController: UIViewController {
    var businesses = [Business]()
    
    @IBOutlet var distanceTxtFld: UITextField!
    @IBOutlet var locationTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findFirstHalf()  // hard corded, remove this when insert realtime location
        
    }
    
    // ,"hot_air_balloons","sailing","skydiving","surfing","waterparks","zoos","museums","festivals",,"restaurants","souvenirs"
    
    func findFirstHalf() {
        Business.searchWithTerm("", sort:.BestMatched , categories:["nightlife","restaurants","festivals"] , deals: nil, radius_filter: 50000,longitude: 3.105706 ,latitude:101.661973, completion: { (businesses:[Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            for business in businesses {
                self.businesses.append(business)
                print(business.name!)
                print(business.latitude)
                print(business.longitude)
                
            }
            
            print(self.businesses.count)
            
            
        })
        self.findSecondHalf()
    }
    
    
    
    func findSecondHalf() {
        Business.searchWithTerm("", sort: .BestMatched , categories:["wineries","museums","zoos","tours","museums"], deals: nil, radius_filter: 20000, longitude: 3.105706 ,latitude:101.661973 ,completion: { (businesses:[Business]!, error: NSError!) -> Void in
            for business in businesses {
                self.businesses.append(business)
                print(business.name!)
            }
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
    
}


