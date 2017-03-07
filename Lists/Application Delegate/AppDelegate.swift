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

        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "List", in: managedObjectContext)

        if let entityDescription = entityDescription {
            // Create Managed Object
            let list = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)

            print(list)

            do {
                // Save Changes
                try managedObjectContext.save()
                
            } catch {
                // Error Handling
            }
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

}
