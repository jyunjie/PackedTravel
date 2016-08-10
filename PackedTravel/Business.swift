//
//  Business.swift
//  PackedTravel
//
//  Created by JJ on 08/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit
import CoreLocation

class Business: NSObject {
    
    static var businessArray: [Business]?
    
    let name: String?
    let address: String?
    let imageURL: NSURL?
    let categories: String?
    let distance: Double?
    let ratingImageURL: NSURL?
    let reviewCount: NSNumber?
    var longitude = NSNumber()
    var latitude = NSNumber()
    var businessURL : NSURL?
    var reviewUserImage : NSURL?
    var reviewText : String?
    var phoneNum : NSNumber?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            let replacedString = imageURLString!.stringByReplacingOccurrencesOfString("ms.jpg", withString: "348s.jpg")
            imageURL = NSURL(string: replacedString)!
        } else {
            imageURL = nil
        }
        
        
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        var coordinates = ""
        if location != nil {
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
            
            if let coordinatesDict = location!["coordinate"] as? [String:AnyObject] {
                longitude = coordinatesDict["longitude"] as! NSNumber
                latitude = coordinatesDict["latitude"] as! NSNumber
            }
        }
        self.address = address
        
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joinWithSeparator(", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? Double
        if distanceMeters != nil {
            distance = distanceMeters
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = NSURL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        let snippetURLString = dictionary["snippet_image_url"] as? String
        if snippetURLString != nil {
            reviewUserImage = NSURL(string: snippetURLString!)
        } else {
            reviewUserImage = nil
        }
        
        let websiteURL = dictionary["url"] as? String
        if websiteURL != nil {
            businessURL = NSURL(string: websiteURL!)
        } else {
            businessURL = nil
        }
        
        let snippetText = dictionary["snippet_text"] as? String
        if snippetText != nil {
            reviewText = snippetText!
        } else {
            reviewText = nil
        }
        
        let phoneNumber = dictionary["phone"] as? NSNumber
        if phoneNumber != nil {
            phoneNum = phoneNumber!
        } else {
            phoneNum = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, longitude: CGFloat, latitude: CGFloat, completion: ([Business]!, NSError!) -> Void) {
        YelpClient.sharedInstance.searchWithTerm(term, longitude: longitude, latitude: latitude, completion: completion)
    }
    
    class func searchWithTerm(term: String,sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius_filter: Int?, longitude: CGFloat, latitude: CGFloat ,completion: ([Business]!, NSError!) -> Void) -> Void {
        YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals,radius_filter: radius_filter , longitude: longitude, latitude: latitude, completion: completion)
    }
}

