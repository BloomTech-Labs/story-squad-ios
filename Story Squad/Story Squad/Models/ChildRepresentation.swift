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
        case child
        
        //swiftlint:disable:next nesting
        enum ChildPropertiesCodingKeys: String, CodingKey {
            
            case username
            case id
            case cohort
            case grade
            case avatar
            case dyslexiaPreference = "preferences"
            //            case name
            //            case parent
            //            case pin
            
            //swiftlint:disable:next nesting
            enum DyslexiaCodingKeys: String, CodingKey {
                case dyslexia
            }
        }
    }
    
    var id: Int16
    var username: String?
    var grade: Int16
    var dyslexiaPreference: Bool = false
    var avatar: String?
    
    //    var name: String
    //    var parent: ParentRepresentation
    //    var cohort: String?
    //    var pin: Int16
    
    // Regular init
    init(name: String?, id: Int16, username: String?, cohort: String?, grade: Int16, dyslexiaPreference: Bool, pin: Int16?, avatar: String?) {
        //        init(name: String, id: String, username: String?, cohort: String?, grade: Int16, dyslexiaPreference: Bool, pin: Int16, avatar: String?) {
        
        self.id = id
        self.username = username
        self.grade = grade
        self.dyslexiaPreference = dyslexiaPreference
        self.avatar = avatar
        
        //        self.name = name
        //        self.parent = parent
        //        self.cohort = cohort
        //        self.pin = pin
    }
    
    // init when Decoding
    init(from decoder: Decoder) throws {
        
        let childContainer = try decoder.container(keyedBy: ChildCodingKeys.self)
        let propertiesContainer = try childContainer.nestedContainer(keyedBy: ChildCodingKeys.ChildPropertiesCodingKeys.self, forKey: .child)
        let dyslexiaContainer = try propertiesContainer.nestedContainer(keyedBy: ChildCodingKeys.ChildPropertiesCodingKeys.DyslexiaCodingKeys.self, forKey: .dyslexiaPreference)
        
        id = try propertiesContainer.decode(Int16.self, forKey: .id)
        username = try propertiesContainer.decode(String?.self, forKey: .username)
        grade = try propertiesContainer.decode(Int16.self, forKey: .grade)
        dyslexiaPreference = try dyslexiaContainer.decode(Bool.self, forKey: .dyslexia)
        avatar = try propertiesContainer.decode(String?.self, forKey: .avatar)
        
        //        name = try propertiesContainer.decode(String.self, forKey: .name)
        //        parent = try propertiesContainer.decode(ParentRepresentation.self, forKey: .parent)
        //        cohort = try propertiesContainer.decode(String?.self, forKey: .cohort)
        //        pin = try propertiesContainer.decode(Int16.self, forKey: .pin)
        
        //            parent = nil
        //           name = ""
        //            pin = 1234
        //            cohort = ""
    }
}
