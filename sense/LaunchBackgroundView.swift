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
            
            var gradientLayer = CAGradientLayer()
            
//            var topColor = UIColor(hex: 0xF7931E)
//            var bottomColor = UIColor(hex: 0xFF1D25)
//            
//            gradientLayer.colors = [topColor.CGColor, bottomColor.CGColor]
//            gradientLayer.locations = [0.0, 1.0]
//            
//            var startPoint = CGPointMake(CGRectGetMidX(self.bounds), 0)
//            var endPoint = CGPointMake(CGRectGetMidX(self.bounds), self.bounds.size.height)
//            
//            gradientLayer.startPoint = startPoint
//            gradientLayer.endPoint = endPoint
//            gradientLayer.frame = self.frame
//            self.layer.addSublayer(gradientLayer)
        }
    }
}
