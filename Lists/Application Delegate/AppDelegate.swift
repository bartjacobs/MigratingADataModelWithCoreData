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

    let coreDataManager = CoreDataManager(modelName: "Lists")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let managedObjectContext = coreDataManager.managedObjectContext

        // Helpers
        var list: NSManagedObject? = nil

        // Fetch List Records
        let lists = fetchRecordsForEntity("List", inManagedObjectContext: managedObjectContext)

        if let listRecord = lists.first {
            list = listRecord
        } else if let listRecord = createRecordForEntity("List", inManagedObjectContext: managedObjectContext) {
            list = listRecord
        }

        print("number of lists: \(lists.count)")
        print("--")

        if let list = list {
            print(list.value(forKey: "name") ?? "no name")
            print(list.value(forKey: "createdAt") ?? "no creation date")

            if list.value(forKey: "name") == nil {
                list.setValue("Shopping List", forKey: "name")
            }

            if list.value(forKey: "createdAt") == nil {
                list.setValue(Date(), forKey: "createdAt")
            }
        } else {
            print("unable to fetch or create list")
        }

        do {
            // Save Managed Object Context
            try managedObjectContext.save()
            
        } catch {
            print("Unable to save managed object context.")
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

}
