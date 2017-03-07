//
//  AppDelegate.swift
//  Lists
//
//  Created by Bart Jacobs on 07/03/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let didSeedPersistentStore = "didSeedPersistentStore"

    let coreDataManager = CoreDataManager(modelName: "Lists")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let managedObjectContext = coreDataManager.managedObjectContext

        // Seed Persistent Store
        seedPersistentStoreWithManagedObjectContext(managedObjectContext)
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")

        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        // Add Predicate
        let predicate1 = NSPredicate(format: "completed = 1")
        let predicate2 = NSPredicate(format: "%K = %@", "list.name", "Home")
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])

        do {
            let records = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]

            for record in records {
                print(record.value(forKey: "name") ?? "no name")
            }
            
        } catch {
            print(error)
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    // MARK: - Helper Methods

    private func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject?

        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)

        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }

    private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

        // Helpers
        var result = [NSManagedObject]()

        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }

        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }

    private func seedPersistentStoreWithManagedObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        guard !UserDefaults.standard.bool(forKey: didSeedPersistentStore) else { return }

        let listNames = ["Home", "Work", "Leisure"]

        for listName in listNames {
            // Create List
            if let list = createRecordForEntity("List", inManagedObjectContext: managedObjectContext) {
                // Populate List
                list.setValue(listName, forKey: "name")
                list.setValue(Date(), forKey: "createdAt")

                // Add Items
                for i in 1...10 {
                    // Create Item
                    if let item = createRecordForEntity("Item", inManagedObjectContext: managedObjectContext) {
                        // Set Attributes
                        item.setValue("Item \(i)", forKey: "name")
                        item.setValue(Date(), forKey: "createdAt")
                        item.setValue(NSNumber(value: (i % 3 == 0)), forKey: "completed")

                        // Set List Relationship
                        item.setValue(list, forKey: "list")
                    }
                }
            }
        }
        
        do {
            // Save Managed Object Context
            try managedObjectContext.save()

        } catch {
            print("Unable to save managed object context.")
        }

        // Update User Defaults
        UserDefaults.standard.set(true, forKey: didSeedPersistentStore)
    }

}
