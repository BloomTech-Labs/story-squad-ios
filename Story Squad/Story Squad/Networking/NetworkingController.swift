//
//  NetworkingController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class NetworkingController {
    
    // MARK: - Properties
   // private let baseURL = URL(string: "")!
    var parent: Parent?
    var children: [Child]?
    var child: Child?

    // MARK: - Parent CRUD Methods
    
    // MARK: - Create Parent
    func createParent(name: String, email: String, password: String, pin: Int16, context: NSManagedObjectContext) {
        
        let id = Int16.random(in: 1..<1000)
        let parent = Parent(name: name, id: id, email: email, password: password, pin: pin, context: CoreDataStack.shared.mainContext)
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Update Parent
    func updateParent () {
        
    }
    
    // Delete Parent
    func deleteParent () {
        
    }
    
    // Create Child
    func createChild(name: String, id: Int16?, username: String?, pin: Int16, grade: Int16, cohort: String?, dyslexiaPreference: Bool, avatar: Data?, context: NSManagedObjectContext) {
        
        guard let parent = self.parent else { return }
        let randomID = Int16.random(in: 1..<1000)
        
        let child = Child(name: name, id: randomID, username: username, parent: parent, pin: pin, grade: grade, cohort: cohort, dyslexiaPreference: dyslexiaPreference, avatar: avatar, context: context)
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Update Child
    func updateChild(name: String, id: Int16?, username: String?, pin: Int16, grade: Int16, cohort: String?, dyslexiaPreference: Bool, avatar: Data?, context: NSManagedObjectContext) {
        
        guard let id = id,
            let childFetched = fetchChildFromCD(with: id),
            let parent = childFetched.parent else { return }
        
//        let moc = CoreDataStack.shared.mainContext
//        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
//        let childrenByID = [id]
//        fetchRequest.predicate = NSPredicate(format: "id IN %@", childrenByID)
//
//        let possibleChildren = try? moc.fetch(fetchRequest)
//
//        guard let children = possibleChildren else { return nil }
//        for child in children {
//
//            if childFetched.id == id {
//                self.child = child
//            } else {
//                print("Couldn't fetch child from CoreData")
//            }
//        }


        
        
        
        
        let newChild = Child(name: name, id: id, username: username, parent: parent, pin: pin, grade: grade, cohort: cohort, dyslexiaPreference: dyslexiaPreference, avatar: avatar, context: context)
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Delete Child
    func deleteChild() {
        
    }
    
    // MARK: - Fetch From CoreData
    
    // Parent
    func fetchParentFromCD(with id: Int16) -> Parent? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Parent> = Parent.fetchRequest()
        let parentsByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", parentsByID)
        
        let possibleParents = try? moc.fetch(fetchRequest)
        
        guard let parents = possibleParents else { return nil }
        for parent in parents {
            
            if parent.id == id {
                self.parent = parent
            } else {
                print("Couldn't fetch parent from CoreData")
            }
        }
        return parent
    }
    
    // Child
    func fetchChildFromCD(with id: Int16) -> Child? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        let childrenByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", childrenByID)
        
        let possibleChildren = try? moc.fetch(fetchRequest)
        
        guard let children = possibleChildren else { return nil }
        for child in children {
            
            if child.id == id {
                self.child = child
            } else {
                print("Couldn't fetch child from CoreData")
            }
        }
        return child
    }
    
    

}
