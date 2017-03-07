### [Working With Managed Objects In Core Data](https://cocoacasts.com/working-with-managed-objects-in-core-data/)

#### Author: Bart Jacobs

In this tutorial, we take a look at the `NSManagedObject` class, a key class of the Core Data framework. You learn how to create a managed object, what classes are involved, and how a managed object is saved to a persistent store.

## Exploring `NSManagedObject`

At first glance, `NSManagedObject` instances may appear to be glorified dictionaries. All they seem to do is manage a collection of key-value pairs. It is true that the `NSManagedObject` class is a generic class, but it implements the fundamental behavior required for model objects in Core Data. Let me explain what that means.

Every `NSManagedObject` instance has a number of properties that tell Core Data about the model object. The properties that interest us most are `entity` and `managedObjectContext`.

### Entity Description

Every managed object has an entity description, an instance of the `NSEntityDescription` class. The entity description is accessible through the `entity` property.

Do you remember that we explored and defined entities in [the tutorial about data models](https://cocoacasts.com/data-model-entities-and-attributes/)? An instance of the `NSEntityDescription` class represents an entity of the data model.

The entity description refers to a specific entity of the data model and it knows about the attributes and relationships of that entity. Every managed object is associated with an entity description. No exceptions.

### Managed Object Context

A managed object should always be associated with a managed object context. There are no exceptions to this rule. Remember that a managed object context manages a number of records or managed objects. As a developer, you primarily interact with managed objects and the managed object context they belong to.

Why is a managed object context important? If you've read the [tutorial about the Core Data stack](https://cocoacasts.com/exploring-the-core-data-stack/), then you know that the persistent store coordinator bridges the gap between the persistent store and the managed object context. In the managed object context, records (managed objects) are created, updated, and deleted. Because the managed object context is unaware of the persistent store, it pushes its changes to the persistent store coordinator, which updates the persistent store.

![Working With Managed Objects in Core Data | Pushing Changes to Persistent Store](https://cocoacasts.s3.amazonaws.com/working-with-managed-objects-in-core-data/figure-diagram-1.jpg)

**Read this article on [Cocoacasts](https://cocoacasts.com/working-with-managed-objects-in-core-data/)**.
