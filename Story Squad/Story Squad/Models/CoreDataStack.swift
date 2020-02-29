//
//  CoreDataStack.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

	static let shared = CoreDataStack()

	// Setup a persistent container
	lazy var container: NSPersistentContainer = {

		let container = NSPersistentContainer(name: "StorySquad")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				fatalError("Failed to load persistent stores: \(error)")
			}
		}

		// MARK: Automatically merging changes from parent
        container.viewContext.automaticallyMergesChangesFromParent = true
		return container
	}()

	var mainContext: NSManagedObjectContext {
		return container.viewContext
	}

	func save(context: NSManagedObjectContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context: \(error)")
                context.reset()
            }
        }
    }

	func saveToPersistentStore() {
		do {
			try mainContext.save()
		} catch {
			NSLog("Error saving context: \(error)")
			// resets the main context if there is an error
			mainContext.reset()
		}
	}
}
