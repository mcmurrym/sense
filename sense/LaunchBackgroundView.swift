//
//  LaunchBackgroundView.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class LaunchBackgroundView: UIView {

    var layerAdded = false
    
    override func layoutSubviews() {
        if !layerAdded {
            
            layerAdded = true
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.frame
            
            let topColor = UIColor(hex: 0xF7931E).CGColor
            let bottomColor = UIColor(hex: 0xFF1D25).CGColor
            
            let colors: [AnyObject] = [topColor, bottomColor]
            
            gradientLayer.colors = colors
            gradientLayer.locations = [0.0, 1.0]
            
            var startPoint = CGPointMake(0.5, 0)
            var endPoint = CGPointMake(0.5, 1)
            
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint

            self.layer.addSublayer(gradientLayer)
        }
    }
}
