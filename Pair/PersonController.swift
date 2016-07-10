//
//  PersonController.swift
//  Pair
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation
import CoreData
import GameplayKit


class PersonController {
    
    static let sharedController = PersonController()
    
    var persons: [Person]{
        
        let request = NSFetchRequest(entityName: "Person")
        let moc = Stack.sharedStack.managedObjectContext
      
        return (try? moc.executeFetchRequest(request)) as? [Person] ?? []
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
    
    func addPerson(fullName: String){
        
        let _ = Person(fullName: fullName)
        saveToPersistentStorage()
    }
    
    func deletePerson(person: Person){
        person.managedObjectContext?.deleteObject(person)
        saveToPersistentStorage()
    }
    
    //Random func
    
    func shuffleArray<T>(var array: [T]) -> [T] {
        for index in (0..<array.count) {
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            (array[index], array[randomIndex]) = (array[randomIndex], array[index])
        }
        return array
    }
}






