//
//  ParentRepresentation.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ParentRepresentation: Codable {

	enum ParentCodingKeys: String, CodingKey {
		case name
		case password
		case email
		case children
		case id
		case pin
	}

	var name: String
	var password: String
	var email: String
	var children: [ChildRepresentation]?
	var id: String
	var pin: Int16
    
    init(name: String, id: String, email: String, password: String, pin: Int16, children: [ChildRepresentation] = []) {
        
        self.name = name
        self.id = id
        self.email = email
        self.password = password
        self.pin = pin
        self.children = children
    }
    
    init(from decoder: Decoder) throws {
        let parentContainer = try decoder.container(keyedBy: ParentCodingKeys.self)
        //            let userContainer = try container.nestedContainer(keyedBy: ConsumerCodingKeys.userCodingKeys.self, forKey: .user)
        
        name = try parentContainer.decode(String.self, forKey: .name)
        password = try parentContainer.decode(String.self, forKey: .password)
        email = try parentContainer.decode(String.self, forKey: .email)
        children = try parentContainer.decode([ChildRepresentation].self, forKey: .children)
        id = try parentContainer.decode(String.self, forKey: .id)
        pin = try parentContainer.decode(Int16.self, forKey: .pin)
    }
}
