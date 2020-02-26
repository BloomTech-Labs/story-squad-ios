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
	var id: Int16
	var pin: Int16
}
