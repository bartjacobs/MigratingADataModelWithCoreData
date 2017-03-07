### [More Fetching and Deleting Managed Objects With Core Data](https://cocoacasts.com/more-fetching-and-deleting-managed-objects-with-core-data/)

#### Author: Bart Jacobs

The final piece of the [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) puzzle covers deleting records from a persistent store. I can assure you that deleting records is no rocket science.

We also take a closer look at the `NSFetchRequest` class. In the [previous tutorial](https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/), we used this class to fetch the records of an entity. But `NSFetchRequest` has a lot more to offer.

If you want to follow along, download or clone the project we created in the [previous tutorial](https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/) from [GitHub](https://github.com/bartjacobs/ReadingAndUpdatingManagedObjectsWithCoreData) and fire up Xcode.

## How to Delete a Record From a Persistent Store

Remember from the [previous tutorial](https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/) that an item record is added to the list record every time the application is run. Add several item records to the list record by running the application a few times. This is what you should see in the console:

```bash
number of lists: 1
--
number of items: 10
---
Item 9
Item 3
Item 10
Item 4
Item 5
Item 6
Item 7
Item 1
Item 8
Item 2
```

Deleting a record from a persistent store involves three steps:

- fetch the record that needs to be deleted
- mark the record for deletion
- save the changes

To show you how to delete a record, we delete an item record from the list record every time the application is run. If the list record has no item records left, we delete the list record itself.

Since we are focusing on deleting items, you can remove or comment out the code we added to `application(_:didFinishLaunchingWithOptions:)` to add new item records.

### Deleting an Item Record

Remember that we obtained the list's item records by invoking `mutableSetValue(forKey:)`. It returns a mutable set (`NSMutableSet`) of `NSManagedObject` instances. We can obtain a random item record by invoking `anyObject()` on the mutable set.

```swift
let items = list.mutableSetValue(forKey: "items")

if let anyItem = items.anyObject() as? NSManagedObject {
    print(anyItem.value(forKey: "name") ?? "no name")
}
```

If you run the application, the name of a random item record is printed to the console. To delete the item record, we invoke `delete(_:)` on the managed object context the item record belongs to, passing in the item record as an argument. Remember that every managed object is tied to a managed object context.

```swift
let items = list.mutableSetValue(forKey: "items")

if let anyItem = items.anyObject() as? NSManagedObject {
    managedObjectContext.delete(anyItem)
}
```

Every time you run the application, a random item record is deleted from the persistent store.

```bash
number of lists: 1
--
number of items: 5
---
Item 8
Item 9
Item 7
Item 2
Item 10
```

### Deleting a List Record

If no item records are left, we delete the list record to which the item records belonged.

```swift
let items = list.mutableSetValue(forKey: "items")

if let anyItem = items.anyObject() as? NSManagedObject {
    managedObjectContext.delete(anyItem)
} else {
    managedObjectContext.delete(list)
}
```

```bash
number of lists: 1
--
number of items: 0
---
```

**Read this article on [Cocoacasts](https://cocoacasts.com/more-fetching-and-deleting-managed-objects-with-core-data/)**.
