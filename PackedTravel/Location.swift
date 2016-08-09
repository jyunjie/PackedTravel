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
    
    var lng: Float!
    var lat: Float!
    var address: String!
    
    
    init(json: JSON) {
        print("running1")
        let result = json["results"][0]["geometry"]["location"]
        self.lat = result["lat"].float
        self.lng = result["lng"].float
    }
    
}