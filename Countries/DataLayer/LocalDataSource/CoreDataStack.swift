//
//  CoreDataStack.swift
//  Countries
//
//  Created by Abdelrahman Hussien [Pharma] on 8/1/25.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Countries")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
