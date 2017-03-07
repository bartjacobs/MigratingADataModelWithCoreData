### [Reading and Updating Managed Objects With Core Data](https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/)

#### Author: Bart Jacobs

In the [previous tutorial](https://cocoacasts.com/working-with-managed-objects-in-core-data/), we created a list record and pushed it to the persistent store by saving its managed object context. The persistent store coordinator handled the nitty-gritty details of inserting the list record into the persistent store. This tutorial focuses on reading and updating records.

## Before We Start

We continue where we left off in the [previous tutorial](https://cocoacasts.com/working-with-managed-objects-in-core-data/). Download or clone the project from [GitHub](https://github.com/bartjacobs/WorkingWithManagedObjectsInCoreData) and open it in Xcode.

```bash
git clone https://github.com/bartjacobs/WorkingWithManagedObjectsInCoreData
```

Before we dive into today's topic, I'd like to refactor the code we wrote in the [previous tutorial](https://cocoacasts.com/working-with-managed-objects-in-core-data/) by creating a generic method for creating records. Open **AppDelegate.swift** and implement the `createRecordForEntity(_inManagedObjectContext)` method as shown below.

```swift
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
```

The implementation should look familiar if you read the [previous tutorial](https://cocoacasts.com/working-with-managed-objects-in-core-data/) of this series. With `createRecordForEntity(_inManagedObjectContext)` implemented, update `application(_:didFinishLaunchingWithOptions:)` as shown below. We create a list record using the new helper method.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let managedObjectContext = coreDataManager.managedObjectContext

    let _ = createRecordForEntity("List", inManagedObjectContext: managedObjectContext)

    do {
        // Save Managed Object Context
        try managedObjectContext.save()

    } catch {
        print("Unable to save managed object context.")
    }

    return true
}
```

This looks much better. However, we don't want to create a list record every time we run the application. To avoid this scenario, we need to fetch every list record from the persistent store and only create a list record if the persistent store doesn't contain any list records yet. To implement this solution, we first need to learn how to fetch records from a persistent store.

**Read this article on [Cocoacasts](https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/)**.
