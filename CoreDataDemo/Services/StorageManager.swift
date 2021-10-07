//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by iMac on 07.10.2021.
//


import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Core Data Getting context
    func getContext() -> NSManagedObjectContext {
        let context = persistentContainer.viewContext
        return context
    }
    
    //MARK: Entity Description
    func entityDescription () -> String {
        let context = getContext()
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return "" }
        
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return ""}
        
        let taskName = task.title ?? ""
        return taskName
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

