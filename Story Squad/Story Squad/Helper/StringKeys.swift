//
//  StringKeys.swift
//  Story Squad
//
//  Created by Percy Ngan on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

extension String {

	static var addChildSegue = "AddChild"
    
    // Notification Pattern Keys
    static var passDataForParentString = "co.lambda.pasDataForParent"
    static var passDataForChildString = "co.lambda.pasDataForChild"
    
    // UserDefault Keys for saving Parent Bearer
    static var parentBearerString = "ParentBearer"
    static var parentEmailString = "ParentEmail"
    static var parentPassString = "ParentPassword"
}
