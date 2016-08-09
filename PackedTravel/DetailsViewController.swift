//
//  DetailsViewController.swift
//  PackedTravel
//
//  Created by JJ on 08/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var userReviewLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var business : Business!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = business.name
        locationLabel.text = business.address
        let distance = Int(business.distance!)
        distanceLabel.text = String("\(distance/1000)km")
        let reviewCount = business.reviewCount as! Int
        ratingLabel.text = String("\(reviewCount) reviews")
        ratingImageView.sd_setImageWithURL(business.ratingImageURL!)
        imageView.sd_setImageWithURL(business.imageURL!)
        imageView.contentMode = .ScaleToFill
        if let number = business.phoneNum{
            phoneNumberLabel.text = String(number)
        }else{
            phoneNumberLabel.text = ""
        }
        
        userReviewLabel.text = business.reviewText
        userProfileImageView.sd_setImageWithURL(business.reviewUserImage)
        
    }
 
}
