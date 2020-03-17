//
//  SignUpTextField.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {

        let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
            
        }
    }
