//
//  PlacesViewController.swift
//  PackedTravel
//
//  Created by JJ on 05/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit
import Koloda
import SDWebImage

class PlacesViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    @IBOutlet weak var kolodaView: KolodaView!
    weak var dataSource: KolodaViewDataSource!
    weak var delegate: KolodaViewDelegate?
    var businesses = [Business]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return 3
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let indexPath: NSIndexPath = NSIndexPath(forRow: Int(index), inSection: 0)
        let selectedItems = businesses[indexPath.row]
        let imageUrl =  selectedItems.imageURL!
        let image = UIImageView()
        image.sd_setImageWithURL(imageUrl)
        return image
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}


  
    
    
    
   
