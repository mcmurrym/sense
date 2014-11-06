//
//  Bubble.swift
//  sense
//
//  Created by Matt McMurry on 11/5/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class Bubble: UIView {

    var intersect: CGPoint = CGPointZero
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        UIColor.whiteColor().setFill()

        let iRect = CGRectInset(rect, rect.size.width / 4, rect.size.height / 4)
        
        let bez = UIBezierPath(ovalInRect: iRect)
        bez.fill()
    }

}
