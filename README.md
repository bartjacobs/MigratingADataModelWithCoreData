### [Migrating a Data Model With Core Data](https://cocoacasts.com/migrating-a-data-model-with-core-data/)

#### Author: Bart Jacobs

An application that grows and gains features also gains new requirements. The data model, for example, grows and changes. Core Data handles changes pretty well as long as you play by the rules of the framework.

In this tutorial, we take a look at how Core Data helps us manage changes of the data model and what pitfalls we absolutely need to avoid.

## Modifying the Data Model

[Download or clone the project](https://github.com/bartjacobs/MoreFetchingAndDeletingManagedObjects) we created in the [previous tutorial](https://cocoacasts.com/more-fetching-and-deleting-managed-objects-with-core-data/) and open it in Xcode. Run the application in the simulator or on a physical device to make sure everything is set up correctly.

```bash
git clone https://github.com/bartjacobs/MoreFetchingAndDeletingManagedObjects
```

Open the project's data model by selecting **Lists.xcdatamodeld** in the **Project Navigator**. Add an entity to the data model and name it **User**. Add two attributes to the **User** entity:

- `firstName` of type `String`
- `lastName` of type `String`

Add a relationship, `lists`, to the **User** entity and set its destination to the **List** entity. In the **Data Model Inspector**, set **Type** to **To Many**.

Select the **List** entity and create a **To One** relationship with the **User** entity as its destination. Name the relationship `user` and set the inverse relationship to `lists`. Remember that the inverse relationship of the `lists` relationship is automatically set for us by Core Data. This is what the data model now looks like.

![Migrating a Data Model With Core Data | Updating the Data Model](https://cocoacasts.s3.amazonaws.com/migrating-a-data-model-with-core-data/figure-modify-data-model-1.jpg)

It's time to verify that everything is still working. Run the application in the simulator or on a physical device. Ouch. Did that crash take you by surprise? That's what happens if you mess with the data model without telling Core Data about it.

In this tutorial, we find out what happened, how we can prevent it, and how we can modify the data model without running into a crash.

## Finding the Root Cause

Finding out the cause of the crash is easy. Open **CoreDataManager.swift** and inspect the implementation of the `persistentStoreCoordinator` property. If adding the persistent store to the persistent store coordinator fails, the application invokes the `fatalError()` function, which causes the application to terminate immediately.

![Migrating a Data Model With Core Data | Terminating the Application](https://cocoacasts.s3.amazonaws.com/migrating-a-data-model-with-core-data/figure-core-data-abort-1.jpg)

The goal of this tutorial is to prevent that adding the persistent store to the persistent store coordinator fails. Run the application again and inspect the output in the console. The following line tells us what went wrong.

```bash
reason = "The model used to open the store is incompatible with the one used to create the store";
```

We are closing in on the root of the problem. Core Data tells us that the data model is not compatible with the data model we used to create the persistent store. What does that mean? When you downloaded or cloned the project from GitHub, I asked you to run the application to make sure everything was set up correctly. By running the application for the first time, Core Data automatically created a persistent store based on the data model of the project.

We then modified the data model by creating the **User** entity and defining several attributes and relationships. With the new data model in place, we ran the application again. And you know what happened next.

Before a persistent store is added to the persistent store coordinator, Core Data checks if a persistent store already exists. If it finds one, Core Data makes sure the data model is compatible with the persistent store. How this works becomes clear in a moment.

The error message in the console indicates that the data model that was used to create the persistent store is not identical to the current data model. As a result, Core Data bails out and throws an error. Read this paragraph again. It is important that you understand the root cause of the problem.

**Read this article on [Cocoacasts](https://cocoacasts.com/migrating-a-data-model-with-core-data/)**.
