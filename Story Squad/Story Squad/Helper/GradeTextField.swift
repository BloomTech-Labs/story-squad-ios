//
//  GradeTextField.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class GradeTextField: UITextField {

        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            
            if action == #selector(UIResponderStandardEditActions.copy(_:)) ||
                action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
                action == #selector(UIResponderStandardEditActions.paste(_:)) ||
                action == #selector(UIResponderStandardEditActions.cut(_:)) {
                return false
            }
            // Default
            return super.canPerformAction(action, withSender: sender)
        }
    }
