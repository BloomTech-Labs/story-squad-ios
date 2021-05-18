//
//  UIView+Constrain.swift
//  Story Squad
//
//  Created by Norlan Tibanear on 5/15/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

extension UIView {
   
   // Add Subview Using Auto Layout extension
   func addSubviewsUsingAutolayout(_ views: UIView...) {
       for view in views {
           view.translatesAutoresizingMaskIntoConstraints = false
           addSubview(view)
       }
   }
   

   func fillSuperview() {

       anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor, centerX: superview?.centerXAnchor, centerY: superview?.centerYAnchor)

   }

   

   func anchorSize(to view: UIView) {

       widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

       heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

   }

   
   // This is the order that needs to be set the constrain
   func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {

       translatesAutoresizingMaskIntoConstraints = false

       

       if let top = top {

           topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true

       }

       

       if let leading = leading {

           leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true

       }

       

       if let trailing = trailing {

           trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true

       }

       

       if let bottom = bottom {

           bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true

       }

       

       if let centerX = centerX {

           centerXAnchor.constraint(equalTo: centerX).isActive = true

       }

       

       if let centerY = centerY {

           centerYAnchor.constraint(equalTo: centerY).isActive = true

       }

       

       if size.width != 0 {

           widthAnchor.constraint(equalToConstant: size.width).isActive = true

       }

       

       if size.height != 0 {

           heightAnchor.constraint(equalToConstant: size.height).isActive = true

       }

   }

   

   func setSize(width: CGFloat, height: CGFloat) {

       translatesAutoresizingMaskIntoConstraints = false

       widthAnchor.constraint(equalToConstant: width).isActive = true

       heightAnchor.constraint(equalToConstant: height).isActive = true

   }

   

   func removeConstraints() {

       self.constraints.forEach {

           self.removeConstraint($0)

       }

   }

   
   
}//
