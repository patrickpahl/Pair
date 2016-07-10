//
//  DetailPairTableViewController.swift
//  Pair
//
//  Created by Patrick Pahl on 7/9/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class DetailPairTableViewController: UITableViewController {

    
    var randomArray: [Person] = PersonController.sharedController.shuffleArray(PersonController.sharedController.persons)
    
    let partnersArray: [String] = ["Group 1", "Group 1", "Group 2", "Group 2", "Group 3", "Group 3", "Group 4", "Group 4", "Group 5", "Group 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return randomArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RandomCell", forIndexPath: indexPath)

        let randomPersons = randomArray[indexPath.row]
        
        cell.textLabel?.text = "\(randomPersons.fullName)"
        cell.detailTextLabel?.text = "\(partnersArray[indexPath.row])"

        return cell
    }
    
}
