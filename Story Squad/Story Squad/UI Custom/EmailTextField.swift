//
//  EmailTextField.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/15/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class EmailTextField: UITextField {


   override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
   var textPadding = UIEdgeInsets(
           top: 5,
           left: 10,
           bottom: 5,
           right: 10
       )

       override func textRect(forBounds bounds: CGRect) -> CGRect {
           let rect = super.textRect(forBounds: bounds)
           return rect.inset(by: textPadding)
       }

       override func editingRect(forBounds bounds: CGRect) -> CGRect {
           let rect = super.editingRect(forBounds: bounds)
           return rect.inset(by: textPadding)
       }
   
   
   
   
   convenience init(placeholder: String) {
       self.init(frame: .zero)
       self.placeholder = placeholder
   }
   
   private func configure() {
       translatesAutoresizingMaskIntoConstraints = false
       
       layer.cornerRadius = 5
       
       textColor = .label
       tintColor = .label
       textAlignment = .left
       font = UIFont.preferredFont(forTextStyle: .subheadline)
       adjustsFontSizeToFitWidth = true
       minimumFontSize = 12
       
       backgroundColor = .systemGray6
       autocorrectionType = .no
       returnKeyType = .go
       clearButtonMode = .whileEditing
       
       keyboardType = .emailAddress
       autocapitalizationType = .none
   }
   

   

}//
