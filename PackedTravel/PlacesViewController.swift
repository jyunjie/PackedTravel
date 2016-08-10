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
import pop

private let numberOfCards: UInt = 5
private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1
class PlacesViewController: UIViewController {
    
    @IBOutlet  var kolodaView: CustomKolodaView!

    var businesses = [Business]()
    var selectedBusinesses = [Business]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal        // Do any additional setup after loading the view.
    }
    
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func rightButtonTapped() {
        print(self.kolodaView.currentCardIndex)
        let indexPath: NSIndexPath = NSIndexPath(forRow: Int(self.kolodaView.currentCardIndex), inSection: 0)
        let selectedItems = businesses[indexPath.row]
        selectedBusinesses.append(selectedItems)
        
        
        let barViewControllers = self.tabBarController?.viewControllers
        let vc = barViewControllers![1] as! UINavigationController
        let svc = vc.viewControllers[0] as! ListViewController
        
        
        svc.selectedBusinesses = selectedBusinesses
        print(selectedItems.name)
        kolodaView?.swipe(SwipeResultDirection.Right)
        
        Business.businessArray = selectedBusinesses
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let destination = segue.destinationViewController as? DetailsViewController
            let indexPath: NSIndexPath = NSIndexPath(forRow: Int(self.kolodaView.currentCardIndex), inSection: 0)
            let selectedItems = businesses[indexPath.row]
            destination!.business = selectedItems
        
        } else {
            print("selected cell")
        }
        
    }
    
}

extension PlacesViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        let indexPath: NSIndexPath = NSIndexPath(forRow: Int(index), inSection: 0)
        let selectedItems = businesses[indexPath.row]
        self.performSegueWithIdentifier("detailSegue", sender: self)
        
    }
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation.springBounciness = frameAnimationSpringBounciness
        animation.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

//MARK: KolodaViewDataSource
extension PlacesViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return UInt(businesses.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let indexPath: NSIndexPath = NSIndexPath(forRow: Int(index), inSection: 0)
        let selectedItems = businesses[indexPath.row]
        let imageUrl =  selectedItems.imageURL!
        let image = UIImageView()
        self.title = selectedItems.name
        image.sd_setImageWithURL(imageUrl)
        return image
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
    

}


  
    
    
    
   
