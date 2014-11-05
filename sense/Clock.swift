//
//  Clock.swift
//  sense
//
//  Created by Matt McMurry on 11/5/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

@IBDesignable class Clock: UIView {
    var date: NSDate  {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        self.date = NSDate()
        super.init(frame: frame)
    }
    override init() {
        self.date = NSDate()
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.date = NSDate()
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect) {

        let time = self.getTime()
        
        UIColor(hex: 0x333333).setStroke()
        
        var bezierPath = UIBezierPath(ovalInRect: CGRectInset(rect, 2, 2))
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let translateTransform = CGAffineTransformMakeTranslation(center.x, center.y)
        
        var hourPath = UIBezierPath()
        hourPath.moveToPoint(center)
        hourPath.lineWidth = 1
        
        var hourRadian = M_PI * 2 / 12.0 * time.hour
        let hourRotationTransform = CGAffineTransformMakeRotation(CGFloat(hourRadian))
        let hourCustomRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), hourRotationTransform), translateTransform)
        
        let hourInitialPoint = CGPointMake(center.x, center.y - 4)
        var hourPoint = CGPointApplyAffineTransform(hourInitialPoint, hourCustomRotation)
        
        hourPath.addLineToPoint(hourPoint)
        
        hourPath.stroke()
        
        var minutePath = UIBezierPath()
        minutePath.lineWidth = 1
        minutePath.moveToPoint(center)
        
        var minuteRadian = M_PI * 2 / 60.0 * time.minute
        let minuteRotationTransform = CGAffineTransformMakeRotation(CGFloat(minuteRadian))
        let minuteCustomRotation = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translateTransform), minuteRotationTransform), translateTransform)
        
        let minuteInitialPoint = CGPointMake(center.x, center.y - 6)
        var minutePoint = CGPointApplyAffineTransform(minuteInitialPoint, minuteCustomRotation)
        
        minutePath.addLineToPoint(minutePoint)

        minutePath.stroke()
    }
    
    func getTime() -> (hour: Double, minute: Double) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: self.date)
        
        let hour = Double(components.hour)
        let minute = Double(components.minute)
        let second = Double(components.second)
        
        let currentHour = hour + minute / 60.0
        let currentMinute = minute + second / 60.0
        return (currentHour, currentMinute)
    }
}
