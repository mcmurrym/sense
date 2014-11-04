//
//  AllMoodColorGradientView.swift
//  sense
//
//  Created by Matt McMurry on 10/23/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

@IBDesignable class AllMoodColorGradientView: UIView {

    var gradientLayer: CAGradientLayer?
    override func layoutSubviews() {
        if let gradientLayer = self.gradientLayer {
            gradientLayer.frame = self.bounds
        } else {
            
            let gradientLayer = CAGradientLayer()
            self.gradientLayer = gradientLayer
            gradientLayer.frame = self.bounds
            
            let topColor = UIColor(hex: 0xFF5722).CGColor
            let midColor = UIColor(hex: 0xD4145A).CGColor
            let bottomColor = UIColor(hex: 0x1B1464).CGColor
            
            let colors: [AnyObject] = [topColor, midColor, bottomColor]
            
            gradientLayer.colors = colors
            gradientLayer.locations = [0.0, 0.5, 1.0]
            
            var startPoint = CGPointMake(0.5, 0)
            var endPoint = CGPointMake(0.5, 1)
            
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            
            self.layer.addSublayer(gradientLayer)
        }
    }

}
