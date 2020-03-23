//
//  PageCountProgressView.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PageCountProgressView: UIView {

    var progress: CGFloat = 0.4
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect (x: 2, y: 2, width: rect.width - 4, height: rect.height - 2)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 14.0)
            let trackColor = UIColor(red: 0, green: 0.447, blue: 0.733, alpha: 1).cgColor
            context.setFillColor(trackColor)
            path.fill()
        }
        
    }
    

}
