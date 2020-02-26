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
		case preferencesDyslexia
		case pin
	}

	var name: String
	var username: String
	var parent: ParentRepresentation
	var id: Int16
	var cohort: String
	var grade: Int16
	var preferencesDyslexia: Bool
	var pin: Int16

}
