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
    
    // MARK: - Update Child
    func updateChild() {
        
    }
    
    // MARK: - Delete Child
    func deleteChild() {
        
    }
    

}
