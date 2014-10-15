//
//  EmotionView.swift
//  fleezy-smile
//
//  Created by Matt McMurry on 9/23/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class EmotionView: UIView {

    var smileShape: CAShapeLayer
    var leftEyeShape: CAShapeLayer
    var rightEyeShape: CAShapeLayer
    var strokeColor: UIColor
    var centerOffset: CGFloat
    
    override init(frame: CGRect) {
        self.smileShape = CAShapeLayer()
        self.leftEyeShape = CAShapeLayer()
        self.rightEyeShape = CAShapeLayer()
        self.centerOffset = 0
        self.strokeColor = UIColor.blackColor()
        super.init(frame: frame)
        
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        self.smileShape = CAShapeLayer()
        self.leftEyeShape = CAShapeLayer()
        self.rightEyeShape = CAShapeLayer()
        self.centerOffset = 0
        self.strokeColor = UIColor.blackColor()
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override var center: CGPoint {
        didSet {
            self.updateSmile()
        }
    }
    
    func updateStrokeColor(color: UIColor) {
        self.strokeColor = color;
        self.smileShape.speed = 1
        self.smileShape.strokeColor = self.strokeColor.CGColor
        self.smileShape.speed = 0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.leftEyeShape.fillColor = self.strokeColor.CGColor
        self.rightEyeShape.fillColor = self.strokeColor.CGColor
        CATransaction.commit()
    }
    
    func setup() {
        self.opaque = false
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = self.bounds.size.width / 2.0

        self.smileShape.lineWidth = 9
        self.smileShape.strokeColor = self.strokeColor.CGColor
        self.smileShape.fillColor = UIColor.clearColor().CGColor
        self.smileShape.lineCap = kCALineCapRound
        self.smileShape.speed = 0
        self.layer.addSublayer(self.smileShape)
        
        self.addEyes()
    }
    
    func addEyes() {
        
        var eyeWidth: CGFloat = 14
        var eyeHeight: CGFloat = 22
        var yOffset: CGFloat = 41
        
        self.leftEyeShape.fillColor = self.strokeColor.CGColor
        var rect1 = CGRectMake(self.bounds.size.width / 2 - eyeWidth / 2 - eyeWidth, yOffset, eyeWidth, eyeHeight)
        var eye1Bez = UIBezierPath(ovalInRect: rect1)
        self.leftEyeShape.path = eye1Bez.CGPath
        self.layer.addSublayer(self.leftEyeShape)
        
        self.rightEyeShape.fillColor = self.strokeColor.CGColor
        var rect2 = CGRectMake(self.bounds.size.width / 2 - eyeWidth / 2 + eyeWidth, yOffset, eyeWidth, eyeHeight)
        var eye2Bez = UIBezierPath(ovalInRect: rect2)
        self.rightEyeShape.path = eye2Bez.CGPath
        self.layer.addSublayer(self.rightEyeShape)
    }
    
    func happyPath() -> CGPathRef {
       
        var midX = CGRectGetMidX(self.bounds)
        var midY = CGRectGetMidY(self.bounds)
        
        var yOffset = midY
        var width: CGFloat = 80
        var xOffset: CGFloat = midX - width / 2
        
        var yControlOffset: CGFloat = yOffset + 50
        var xControlInset: CGFloat = 5
        
        var smilePath = UIBezierPath()
        
        smilePath.moveToPoint(CGPointMake(xOffset, yOffset))
        
        var controlPoint1 = CGPointMake(xOffset + xControlInset, yControlOffset)
        var controlPoint2 = CGPointMake(xOffset + width - xControlInset, yControlOffset)
        smilePath.addCurveToPoint(CGPointMake(xOffset + width, yOffset), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return smilePath.CGPath
    }
    
    func neutralPath() -> CGPathRef {
        
        var midX = CGRectGetMidX(self.bounds)
        var midY = CGRectGetMidY(self.bounds)
        
        var yOffset: CGFloat = 84.0
        var width: CGFloat = 63.0
        var xOffset: CGFloat = midX - width / 2
        
        var yControlOffset: CGFloat = yOffset
        var xControlInset: CGFloat = 5
        
        var smilePath = UIBezierPath()
        
        smilePath.moveToPoint(CGPointMake(xOffset, yOffset))
        
        var controlPoint1 = CGPointMake(xOffset + xControlInset, yControlOffset)
        var controlPoint2 = CGPointMake(xOffset + width - xControlInset, yControlOffset)
        smilePath.addCurveToPoint(CGPointMake(xOffset + width, yOffset), controlPoint1: controlPoint1, controlPoint2: controlPoint2)

        return smilePath.CGPath
    }

    func sadPath() -> CGPathRef {
        
        var midX = CGRectGetMidX(self.bounds)
        var midY = CGRectGetMidY(self.bounds)
        
        var yOffset: CGFloat = 94.0
        var width: CGFloat = 57.0
        var xOffset: CGFloat = midX - width / 2
        
        var yControlOffset: CGFloat = yOffset - 15
        var xControlInset: CGFloat = 15
        
        var smilePath = UIBezierPath()
        
        smilePath.moveToPoint(CGPointMake(xOffset, yOffset))
        
        var controlPoint1 = CGPointMake(xOffset + xControlInset, yControlOffset)
        var controlPoint2 = CGPointMake(xOffset + width - xControlInset, yControlOffset)
        smilePath.addCurveToPoint(CGPointMake(xOffset + width, yOffset), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return smilePath.CGPath
    }

    func updateSmile() {
        self.smileShape.removeAnimationForKey("morph")

        var top = self.center.y - self.bounds.size.height / 2
        var yDiff = self.center.y - self.superview!.center.y
        
        if yDiff < 0 {
            var percentageToCenter = top / self.superview!.center.y
            if percentageToCenter < 0 {
                self.smileShape.path = self.happyPath()
            } else {
                var basic = CABasicAnimation(keyPath: "path")
                basic.duration = 1
                basic.fromValue = self.happyPath()
                basic.toValue = self.neutralPath()
                basic.timeOffset = Double(percentageToCenter)
                basic.removedOnCompletion = false
                self.smileShape.addAnimation(basic, forKey: "morph")
            }
        } else if yDiff > 0 {
            var maxYDiff = (self.superview!.frame.size.height - self.centerOffset) / 2 - self.frame.size.height / 2
            
            var percentageToCenter = yDiff / maxYDiff
            
            if percentageToCenter >= 1 {
                self.smileShape.path = self.sadPath()
            } else {
                var basic = CABasicAnimation(keyPath: "path")
                basic.duration = 1
                basic.fromValue = self.neutralPath()
                basic.toValue = self.sadPath()
                basic.timeOffset = Double(percentageToCenter)
                basic.removedOnCompletion = false
                self.smileShape.addAnimation(basic, forKey: "morph")
            }
        } else {
            self.smileShape.path = self.neutralPath()
        }
    }
}
