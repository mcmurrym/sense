//
//  PillButton.swift
//  sense
//
//  Created by Matt McMurry on 10/4/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class PillButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var color = self.titleColorForState(UIControlState.Normal)

        if let color = color {
            self.layer.borderColor = color.CGColor
        }
        
        self.layer.cornerRadius = self.frame.size.height / 2
        
        self.layer.borderWidth = 1
    }
}
