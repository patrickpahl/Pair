//
//  ListPairTableViewController.swift
//  Pair
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit
import CoreData


class ListPairTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
       return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PersonController.sharedController.persons.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell", forIndexPath: indexPath)

        let person = PersonController.sharedController.persons[indexPath.row]
        cell.textLabel?.text = person.fullName
        return cell
    }
    

    //MARK: - Actions
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
    presentAlertController()
    tableView.reloadData()
    }
    
    //MARK: - Alert Controller
    
    func presentAlertController(){
        
        var fullNameTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Name:", message: "Who would you like to add?", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (fnTextField) in
            fnTextField.placeholder = "i.e. Albert Einstein"
            fullNameTextField = fnTextField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            
        guard let fullName = fullNameTextField?.text where fullName.characters.count > 0 else {return}
            
        PersonController.sharedController.addPerson(fullName)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
           let deletedPerson = PersonController.sharedController.persons[indexPath.row]
            
            PersonController.sharedController.deletePerson(deletedPerson)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

