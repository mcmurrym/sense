//
//  LineTip.swift
//  sense
//
//  Created by Matt McMurry on 11/5/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class LineTip: UIView {

    @IBOutlet weak var feelLabel: UILabel!
    @IBOutlet private weak var clock: Clock!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var stepIcon: UIImageView!
    @IBOutlet weak var stepLabel: UILabel!
    var date: NSDate = NSDate() {
        didSet {
            self.clock.date = date
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "h:mma"
            
            let dateString = dateFormatter.stringFromDate(date).lowercaseString
            
            self.timeLabel.text = dateString
        }
    }
    
    let arrowWidth: CGFloat = 10.0
    var drawPointX: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        
        UIColor.whiteColor().colorWithAlphaComponent(0.97).setFill()
        
        let insetRect = CGRectInset(rect, 3, 3)
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(insetRect.origin)
        bezierPath.addLineToPoint(CGPointMake(insetRect.origin.x + insetRect.size.width, insetRect.origin.y))
        bezierPath.addLineToPoint(CGPointMake(insetRect.origin.x + insetRect.size.width, insetRect.origin.y + insetRect.size.height - arrowWidth))
        
        if drawPointX != 0 {
            
            if drawPointX + arrowWidth > insetRect.origin.x + insetRect.size.width {
                drawPointX -= drawPointX + arrowWidth - insetRect.origin.x + insetRect.size.width
            } else if drawPointX - arrowWidth < insetRect.origin.x {
                drawPointX += insetRect.origin.x + drawPointX - arrowWidth
            }
            
            bezierPath.addLineToPoint(CGPointMake(drawPointX + arrowWidth, insetRect.origin.y + insetRect.size.height - arrowWidth))
            bezierPath.addLineToPoint(CGPointMake(drawPointX, insetRect.origin.y + insetRect.size.height))
            bezierPath.addLineToPoint(CGPointMake(drawPointX - arrowWidth, insetRect.origin.y + insetRect.size.height - arrowWidth))
        }
        
        bezierPath.addLineToPoint(CGPointMake(insetRect.origin.x, insetRect.origin.y + insetRect.size.height - arrowWidth))
        bezierPath.addLineToPoint(insetRect.origin)

        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), CGSizeMake(0, 0), 4.0, UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor)
        
        bezierPath.fill()
    }
}
