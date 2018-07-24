//
//  GradientView.swift
//  rrrrrr
//
//  Created by Roman Chopovenko on 7/21/18.
//  Copyright © 2018 Roman Chopovenko. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var startColor: UIColor = .white
    var endColor: UIColor = .red
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .white
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 0.4]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}
