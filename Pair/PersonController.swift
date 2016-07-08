//
//  PersonController.swift
//  Pair
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation
import CoreData


class PersonController {
    
    static let sharedController = PersonController()
    
    let fetchedResultsController: NSFetchedResultsController
    
    
    init(){
        let request = NSFetchRequest(entityName: "Person")
        let lnSortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
        request.sortDescriptors = [lnSortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "lastName", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("fetch error")
        }
    }
    
    //CRUD
    
    func saveToPersistentStorage(){
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("MOC error")
        }
    }
    
    func addPerson(firstName: String, lastName: String){
        
        let _ = Person(firstName: firstName, lastName: lastName)
        saveToPersistentStorage()
    }
    
    func deletePerson(person: Person){
        person.managedObjectContext?.deleteObject(person)
        saveToPersistentStorage()
    }
    
    
    //Random func
    
    func randomGenerator(){
        
       ///???
    }
    
}



//dice1 = arc4random_uniform(6) + 1      //to get a random num between 1 and 6

//dice1 = arc4random_uniform(20) + 10    //to get a random num between 10 and 30













