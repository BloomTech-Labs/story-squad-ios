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

    // MARK: - Parent CRUD Methods
    
    func createParent (name: String, email: String, password: String, pin: Int16, context: NSManagedObjectContext) {
        let id = Int16.random(in: 1..<1000)
        let parent = Parent(name: name, id: id, email: email, password: password, pin: pin, context: CoreDataStack.shared.mainContext)
        CoreDataStack.shared.save(context: context)
    }
    
    
}
