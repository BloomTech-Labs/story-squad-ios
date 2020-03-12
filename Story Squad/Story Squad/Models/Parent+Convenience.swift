//
//  Parent+Convenience.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Parent {
    
        var parentRepresentation: ParentRepresentation? {

		// swiftlint:disable:next unused_declaration
        guard let name = name,
                let email = email,
                let password = password,
                let children = children else { return nil }
//        return ParentRepresentation(name: name, password: password, email: email, children: children, id: id, pin: pin)
            return nil
    }
    
    // MARK: CoreData Inititalizer
    @discardableResult convenience init(name: String, id: String, email: String, password: String, pin: Int16, children: NSOrderedSet = [], context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = name
        self.id = id
        self.email = email
        self.password = password
        self.pin = pin
        self.children = children
    }
    
//    // MARK: Init from Representation
//    @discardableResult convenience init?(parentRepresentation: ParentRepresentation, context: NSManagedObjectContext) {
//
//        self.init(name: parentRepresentation.name,
//                  id: parentRepresentation.id,
//                  email: parentRepresentation.email,
//                  password: parentRepresentation.password,
//                  pin: parentRepresentation.pin,
//                  children: parentRepresentation.children,
//                  context: context)
//    }
}
