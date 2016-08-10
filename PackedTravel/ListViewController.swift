//
//  ListViewController.swift
//  PackedTravel
//
//  Created by JJ on 05/08/2016.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var selectedBusinesses = [Business]()
    var indexPathValue = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedBusinesses)
        self.title = "Itinary"
        self.selectedBusinesses = self.selectedBusinesses.sort({ (first, second) -> Bool in
            return first.distance < second.distance
        })
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        self.selectedBusinesses = self.selectedBusinesses.sort({ (first, second) -> Bool in
            return first.distance < second.distance
        })
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedBusinesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("placeCell", forIndexPath: indexPath)
        let selectedBusiness = self.selectedBusinesses[indexPath.row]
        cell.textLabel?.text = selectedBusiness.name
        cell.detailTextLabel?.text = String(format: "%.2f", selectedBusiness.distance!) + " meter away"
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            let i = self.tableView.indexPathForCell(cell)!.row
            if segue.identifier == "listDetailSegue" {
                let vc = segue.destinationViewController as! ListDetailViewController
                vc.business = self.selectedBusinesses[i]
            }
        }
    }
}
