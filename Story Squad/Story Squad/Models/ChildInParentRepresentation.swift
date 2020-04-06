//
//  ChildInParentRepresentation.swift
//  Story Squad
//
//  Created by macbook on 3/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ChildInParentRepresentation: Codable {
    
    enum ChildPropertiesCodingKeys: String, CodingKey {
        
        case username
        case id
        case cohort
        case grade
        case avatar
        case dyslexiaPreference = "preferences"
        
        //swiftlint:disable:next nesting
        enum DyslexiaCodingKeys: String, CodingKey {
            case dyslexia
        }
    }
    
    var username: String?
    var id: Int16
    var grade: Int16
    var dyslexiaPreference: Bool = false
    var avatar: String?
    
    var name: String?
    var cohort: String?
    var pin: Int16?
    var parent: ParentRepresentation?
    
    // init when Decoding
    init(from decoder: Decoder) throws {
        
        let propertiesContainer = try decoder.container(keyedBy: ChildPropertiesCodingKeys.self)
        let dyslexiaContainer = try propertiesContainer.nestedContainer(keyedBy: ChildPropertiesCodingKeys.DyslexiaCodingKeys.self, forKey: .dyslexiaPreference)
        
        username = try propertiesContainer.decode(String?.self, forKey: .username)
        id = try propertiesContainer.decode(Int16.self, forKey: .id)
        grade = try propertiesContainer.decode(Int16.self, forKey: .grade)
        dyslexiaPreference = try dyslexiaContainer.decode(Bool.self, forKey: .dyslexia)
        avatar = try propertiesContainer.decode(String?.self, forKey: .avatar)
        
        //        name = try propertiesContainer.decode(String.self, forKey: .name)
        //        parent = try propertiesContainer.decode(ParentRepresentation.self, forKey: .parent)
        //        pin = try propertiesContainer.decode(Int16.self, forKey: .pin)
        //        cohort = try propertiesContainer.decode(String?.self, forKey: .cohort)
    }
    
    // Normal init
    init(name: String?, id: Int16, parent: ParentRepresentation?, username: String?, cohort: String?, grade: Int16, dyslexiaPreference: Bool, pin: Int16?, avatar: String?) {
        
        self.id = id
        self.username = username
        self.cohort = cohort
        self.grade = grade
        self.dyslexiaPreference = dyslexiaPreference
        self.pin = pin
        self.avatar = avatar
    }
}
