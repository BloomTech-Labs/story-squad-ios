//
//  PageCountProgressView.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PageCountProgressView: UIView {
    var progress: CGFloat = 0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if let context = UIGraphicsGetCurrentContext() {
            let trackWidth = rect.width - 4
            
            let trackRect = CGRect(x: 2, y: rect.height / 4, width: trackWidth, height: rect.height / 2)
            
            let path = UIBezierPath(roundedRect: trackRect, cornerRadius: 14.0)
           
            let trackColor = UIColor(red: 0, green: 0.447, blue: 0.733, alpha: 0.2).cgColor
            context.setFillColor(trackColor)
            path.fill()
            
            let completedProgressFillColor = UIColor(red: 1, green: 0.427, blue: 0.227, alpha: 1).cgColor
           
            let progressRect = CGRect(x: 2, y: rect.height / 4, width: trackWidth * progress, height: rect.height / 2)
            context.setFillColor(completedProgressFillColor)
            
            let progressPath = UIBezierPath(roundedRect: progressRect, cornerRadius: 14)
            progressPath.fill()
            
            // MARK: - Progress Markers
            
             let circleColor = UIColor(red: 0, green: 0.447, blue: 0.733, alpha: 1).cgColor
             
             let lighterCircleColor = UIColor(red: 0, green: 0.447, blue: 0.733, alpha: 0.3).cgColor
            
             let circleSize: CGFloat = 24
            
            let twentyPercentCircle = CGRect(x: (trackWidth / 5) -      (circleSize / 2),
                                             y: (rect.height / 2) - (circleSize / 2),
                                             width: circleSize,
                                             height: circleSize)
            context.setFillColor(progress >= 0.2 ? circleColor : lighterCircleColor)
            context.addEllipse(in: twentyPercentCircle)
            context.fillPath()
            
            let fortyPercentCircle = CGRect(x: ((trackWidth / 5) * 2) - (circleSize / 2),
                                            y: (rect.height / 2) - (circleSize / 2),
                                            width: circleSize,
                                            height: circleSize)
            context.setFillColor(progress >= 0.4 ? circleColor : lighterCircleColor)
            context.addEllipse(in: fortyPercentCircle)
            context.fillPath()
            
            let sixtyPercentCircle = CGRect(x: ((trackWidth / 5) * 3) - (circleSize / 2),
                                            y: (rect.height / 2) - (circleSize / 2),
                                            width: circleSize,
                                            height: circleSize)
            context.setFillColor(progress >= 0.6 ? circleColor : lighterCircleColor)
            context.addEllipse(in: sixtyPercentCircle)
            context.fillPath()
            
            let eightyPercentCircle = CGRect(x: ((trackWidth / 5) * 4) - (circleSize / 2),
                                             y: (rect.height / 2) - (circleSize / 2),
                                             width: circleSize,
                                             height: circleSize)
            context.setFillColor(progress >= 0.8 ? circleColor : lighterCircleColor)
            context.addEllipse(in: eightyPercentCircle)
            context.fillPath()
        }
    }
}
