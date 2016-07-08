//
//  ListPairTableViewController.swift
//  Pair
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit
import CoreData


class ListPairTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        PersonController.sharedController.fetchedResultsController.delegate = self
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {          ///REVIEW
        
        guard let sectionInfo = PersonController.sharedController.fetchedResultsController.sections,
             index = Int(sectionInfo[section].name) else {return nil}
        
        if index == 0 {
            return "Group 1"
        } else if index == 1 {
            return "Group 2"
        } else if index == 2{
            return "Group 3"
        } else if index == 3{
            return "Group 4"
        } else if index == 4 {
            return "Group 5"
        } else {
            return "Group 6"
        }
        }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
       guard let sections = PersonController.sharedController.fetchedResultsController.sections else {return 0}     ///return 0 or 1??
        
       return sections.count
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let sections = PersonController.sharedController.fetchedResultsController.sections else {return 0}
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell", forIndexPath: indexPath)

        let person = PersonController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Person
        
        cell.textLabel?.text = person?.firstName
        
        return cell
    }
    
    

    //MARK: - Actions
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
    presentAlertController()
        
    }
    
    @IBAction func GeneratePairsButtonTapped(sender: AnyObject) {
        
      /// execute random code func
        
    }
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    
    //MARK: - Alert Controller
    
    func presentAlertController(){
        
        var firstNameTextField: UITextField?
        var lastnameTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Name:", message: "Who would you like to add??", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (fnTextField) in
            fnTextField.placeholder = "i.e. Albert"
            firstNameTextField = fnTextField
        }
        
        alertController.addTextFieldWithConfigurationHandler { (lnTextField) in
            lnTextField.placeholder = "i.e. Einstein"
            lastnameTextField = lnTextField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            
            guard let firstName = firstNameTextField?.text , lastName = lastnameTextField?.text where firstName.characters.count > 0 && lastName.characters.count > 0 else {return}
            
                PersonController.sharedController.addPerson(firstName, lastName: lastName)
        }
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
            guard let person = PersonController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Person else {return}
            
            PersonController.sharedController.deletePerson(person)
            
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


    
    ///NSFetchedResultsControllerDelegate
    
    //FUNC: Controller will change - Listening for changes, will begin updating content.
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    
    //FUNC: controller did change OBJECT- Handle cases with Switch stmt. Types are delete, insert, move, update.
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    //**delete object way above when you swipe to delete, but HERE we actually delete the row in the table too.
    // Here we're just inserting the row
    //**On 'guard let indexPath = indexPath', the first indexPath correlates to the [indexPath] below in the stmt. We can call it whatever we want.
    
    
    //FUNC: controller did change SECTION -    Switch case for sections delete/insert
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    //FUNC: controller did change content - Completes reloading the table view so the app is not constantly updating.
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}



