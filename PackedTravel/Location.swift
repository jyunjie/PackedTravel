//
//  Location.swift
//  PackedTravel
//
//  Created by JJ on 09/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import Foundation
import SwiftyJSON

class Location {
    
    static var currentLocation: Location?

    
    var lng: Double!
    var lat: Double!
    var address: String!
    
    
    init(json: JSON) {
        print("running1")
        let result = json["results"][0]["geometry"]["location"]
        self.lat = result["lat"].double
        self.lng = result["lng"].double
        
        let loc = json["results"][0]
        self.address = loc["formatted_address"].string

    }
    
}