### Setting Up the Core Data Stack From Scratch

#### Author: Bart Jacobs

In the [previous lesson](https://cocoacasts.com/setting-up-the-core-data-stack/), we set up a Core Data stack using the `NSPersistentContainer` class. While this is convenient, it teaches you very little about the Core Data stack and how to set one up from scratch. In this lesson, we create a Core Data stack without relying on Xcode's Core Data template.

## Setting Up the Project

Fire up Xcode and create a new project by choosing the **Single View Application** template.

![Setting Up the Xcode Project](https://cocoacasts.s3.amazonaws.com/setting-up-the-core-data-stack-from-scratch/figure-project-setup-1.jpg)

This time, however, we don't check the **Use Core Data** checkbox. This means that the Xcode project doesn't have any references to the Core Data framework. And that is the approach I always take when working with Core Data. I like to be in charge of things.

![Setting Up the Xcode Project](https://cocoacasts.s3.amazonaws.com/setting-up-the-core-data-stack-from-scratch/figure-project-setup-2.jpg)

If we would have checked the **Use Core Data** checkbox during the setup of the project, Xcode would have put the code for the Core Data stack in the application delegate. This is something I don't like and we won't be cluttering the application delegate with the setup of the Core Data stack.

Instead, we are going to create a separate class that is responsible for setting up and managing the Core Data stack.

## Creating the Core Data Manager

Create a new group and name it **Managers**. Create a new Swift file in the **Managers** group and name the file **CoreDataManager**. This is the class that will be in charge of the Core Data stack of the application.

![Creating the Core Data Manager](https://cocoacasts.s3.amazonaws.com/setting-up-the-core-data-stack-from-scratch/figure-create-core-data-manager-1.jpg)

We start by adding an import statement for the Core Data framework and define the `CoreDataManager` class. Note that we mark it as final. The class is not intended to be subclassed.

```swift
import CoreData

final class CoreDataManager {

}
```

We're going to keep the implementation straightforward. The only information we are going to give the Core Data manager is the name of the data model. We create a property of type `String` for the name of the data model.

```swift
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let modelName: String

}
```

The designated initializer of the class accepts the name of the data model as an argument.

```swift
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let modelName: String

    // MARK: - Initialization

    init(modelName: String) {
        self.modelName = modelName
    }

}
```

**Read this article on [Cocoacasts](https://cocoacasts.com/setting-up-the-core-data-stack-from-scratch/)**.
