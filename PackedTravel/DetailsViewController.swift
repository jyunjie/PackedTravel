//
//  DetailsViewController.swift
//  PackedTravel
//
//  Created by JJ on 08/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var business : Business!
    
    @IBOutlet var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = business.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
