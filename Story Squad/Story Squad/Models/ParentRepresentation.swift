//
//  ParentRepresentation.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ParentRepresentation: Codable {
    
    private enum ParentCodingKeys: String, CodingKey {
        case me
        
        enum MeParentCodingKeys: String, CodingKey {
            
            case email
            case children
            case id
        }
    }
    
    var email: String
    var children: [ChildInParentRepresentation]?
    var id: Int16
    
    var password: String?
    var name: String?
    var pin: Int16?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ParentCodingKeys.self)
        let meContainer = try container.nestedContainer(keyedBy: ParentCodingKeys.MeParentCodingKeys.self, forKey: .me)
        
        email = try meContainer.decode(String.self, forKey: .email)
        children = try meContainer.decode([ChildInParentRepresentation].self, forKey: .children)
        id = try meContainer.decode(Int16.self, forKey: .id)
        
        //        name = try meContainer.decode(String.self, forKey: .name)
        //        password = try meContainer.decode(String?.self, forKey: .password)
        //        pin = try meContainer.decode(Int16.self, forKey: .pin)
    }
    
    init(id: Int16, email: String, children: [ChildInParentRepresentation] = []) {

        self.id = id
        self.email = email
        self.children = children
    }
}
