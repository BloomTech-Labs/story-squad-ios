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
    
    // Create Parent
    func createParent(name: String, email: String, password: String, pin: Int16, context: NSManagedObjectContext) {
        
        let id = Int16.random(in: 1..<1000)
        _ = Parent(name: name, id: id, email: email, password: password, pin: pin, context: CoreDataStack.shared.mainContext)
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
    }
    
    // Update Parent
    func updateParent(name: String?, id: Int16, email: String?, pin: Int16?, password: String?, context: NSManagedObjectContext) {
        
        guard let parent = fetchParentFromCD(with: id) else { return }
        
        // Use new property or old property
        let newName = name ?? parent.name
        let newEmail = email ?? parent.email
        let newPin = pin ?? parent.pin
        let newPassword = password ?? parent.password
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Parent> = Parent.fetchRequest()
        
        // Array with parent that needs to be fetched
        let parentsByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", parentsByID)
        
        // Trying to fetch array of parents
        let fetchedParents = try? moc.fetch(fetchRequest)
        guard let parents = fetchedParents else { return }
        
        for parent in parents {
            
            // Updating Parent
            if parent.id == id {
                parent.name = newName
                parent.email = newEmail
                parent.password = newPassword
                parent.pin = newPin
                
                print("Succefully fetched and updated parent in CoreData")
            } else {
                NSLog("Couldn't fetched and update parent in CoreData")
            }
        }
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
        
        // TODO: WR Check if you need this from Tasks Project
        //        let context = CoreDataStack.shared.container.newBackgroundContext()
        //        context.performAndWait {
    }
    
    // Delete Parent
    func deleteParentFromCoreData(parent: Parent, context: NSManagedObjectContext) {
        context.performAndWait {
            context.delete(parent)
            CoreDataStack.shared.save(context: context)
        }
    }
    
    // MARK: - Child CRUD Methods
    
    // create Child
    func createChildAndAddToParent(parent: Parent, name: String, id: Int16?, username: String?, pin: Int16, grade: Int16, cohort: String?, dyslexiaPreference: Bool, avatar: Data?, context: NSManagedObjectContext) {
        
        let randomID = Int16.random(in: 1..<1000)
        let child = Child(name: name, id: randomID, username: username, parent: parent, pin: pin, grade: grade, cohort: cohort, dyslexiaPreference: dyslexiaPreference, avatar: avatar, context: context)
        
        // Adding child to it's parent in Core Data
        parent.addToChildren(child)
        CoreDataStack.shared.save(context: context)
    }
    
    // Update Child
    func updateChild(name: String?, id: Int16, username: String?, pin: Int16?, grade: Int16?, cohort: String?, dyslexiaPreference: Bool?, avatar: Data?, context: NSManagedObjectContext) {
        
        guard let child = fetchChildFromCD(with: id) else { return }
        
        // Use new property or old property
        let newName = name ?? child.name
        let newUsername = username ?? child.username
        let newPin = pin ?? child.pin
        let newGrade = grade ?? child.grade
        let newCohort = cohort ?? child.cohort
        let newDyslexiaPreference = dyslexiaPreference ?? child.dyslexiaPreference
        let newAvatar = avatar ?? child.avatar
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
        
        // Array with child that needs to be fetched
        let childrenByID = [id]
        fetchRequest.predicate = NSPredicate(format: "id IN %@", childrenByID)
        
        // Trying to fetch array of children
        let fetchedChildren = try? moc.fetch(fetchRequest)
        
        guard let children = fetchedChildren else { return }
        for child in children {
            
            // Updating Child
            if child.id == id {
                child.name = newName
                child.username = newUsername
                child.pin = newPin
                child.grade = newGrade
                child.cohort = newCohort
                child.dyslexiaPreference = newDyslexiaPreference
                child.avatar = newAvatar
                
                print("Succefully fetched and updated child \(name) in CoreData")
            } else {
                NSLog("Couldn't fetched and update child \(name) in CoreData")
            }
        }
        
        // Saving to CoreData
        CoreDataStack.shared.save(context: context)
        
        // TODO: WR Check if you need this from Tasks Project
        //        let context = CoreDataStack.shared.container.newBackgroundContext()
        //        context.performAndWait {
    }
    
    // Delete Child
    func deleteChildFromCoreData(child: Child, context: NSManagedObjectContext) {
        
        context.performAndWait {
            context.delete(child)
            CoreDataStack.shared.save(context: context)
        }
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
