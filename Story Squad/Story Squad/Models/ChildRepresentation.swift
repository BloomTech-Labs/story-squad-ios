//
//  ChildRepresentation.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ChildRepresentation: Codable {

	enum ChildCodingKeys: String, CodingKey {
		case name
		case username
		case parent
		case id
		case cohort
		case grade
		case dyslexiaPreference
		case pin
        case avatar
	}

	var name: String
    var id: String
    var parent: ParentRepresentation
    var username: String?
	var cohort: String?
	var grade: Int16
	var dyslexiaPreference: Bool = false
	var pin: Int16
    var avatar: String?
    
    init(name: String, id: String, parent: ParentRepresentation, username: String?, cohort: String?, grade: Int16, dyslexiaPreference: Bool, pin: Int16, avatar: String?) {
        
        self.name = name
        self.id = id
        self.parent = parent
        self.username = username
        self.cohort = cohort
        self.grade = grade
        self.dyslexiaPreference = dyslexiaPreference
        self.pin = pin
        self.avatar = avatar
    }
    
    init(from decoder: Decoder) throws {
        let childContainer = try decoder.container(keyedBy: ChildCodingKeys.self)
        //            let userContainer = try container.nestedContainer(keyedBy: ConsumerCodingKeys.userCodingKeys.self, forKey: .user)
        
        name = try childContainer.decode(String.self, forKey: .name)
        username = try childContainer.decode(String?.self, forKey: .username)
        parent = try childContainer.decode(ParentRepresentation.self, forKey: .parent)
        id = try childContainer.decode(String.self, forKey: .id)
        cohort = try childContainer.decode(String?.self, forKey: .cohort)
        grade = try childContainer.decode(Int16.self, forKey: .grade)
        dyslexiaPreference = try childContainer.decode(Bool.self, forKey: .dyslexiaPreference)
        pin = try childContainer.decode(Int16.self, forKey: .pin)
        avatar = try childContainer.decode(String?.self, forKey: .avatar)
    }
}
