//
//  Child+Convenience.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Child {
    
        var childRepresentation: ChildRepresentation? {
            
            guard let name = name,
                let username = username,
                let parent = parent?.parentRepresentation,
                let cohort = cohort,
                let avatar = avatar else { return nil }
            
            return ChildRepresentation(name: name, username: username, parent: parent, id: id, cohort: cohort, grade: grade, dyslexiaPreference: dyslexiaPreference, pin: pin, avatar: avatar)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(name: String, id: Int16, username: String?, parent: Parent, pin: Int16, grade: Int16, cohort: String?, dyslexiaPreference: Bool, avatar: Data?, context: NSManagedObjectContext) {
        self.init(context:context)
        
        self.name = name
        self.id = id
        self.parent = parent
        self.pin = pin
        self.username = username
        self.grade = grade
        self.cohort = cohort
        self.dyslexiaPreference = dyslexiaPreference
    }
    
//    // MARK: Init from Representation
//    @discardableResult convenience init?(childRepresentation: ChildRepresentation, context: NSManagedObjectContext) {
//        
//        self.init(name: childRepresentation.name,
//                  id: childRepresentation.id,
//                  username: childRepresentation.username,
//                  parent: childRepresentation.parent,
//                  pin: childRepresentation.pin,
//                  grade: childRepresentation.grade,
//                  cohort: childRepresentation.cohort,
//                  dyslexiaPreference: childRepresentation.dyslexiaPreference,
//                  context: context)
//    }
}

