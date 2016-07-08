//
//  Person.swift
//  Pair
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation
import CoreData


class Person: NSManagedObject {

    convenience init?(firstName: String, lastName: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext){
        
        guard let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.firstName = firstName
        self.lastName = lastName
        
    }
}
