//
//  ViewController.swift
//  fleezy-smile
//
//  Created by Matt McMurry on 9/23/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class MoodLogViewController: UIViewController {

    var smile: EmotionView = EmotionView(frame: CGRectMake(0, 0, 122, 122))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        self.smile.opaque = false
        self.view.addSubview(self.smile)
        
        var pan = UIPanGestureRecognizer(target: self, action: "panned:")
        self.view.addGestureRecognizer(pan)
        
        updateColors()
        
    }
    
    func panned(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == UIGestureRecognizerState.Began {
            println("began")
            
            var touchPoint = panGesture.locationInView(self.view)
            
            var newPoint = self.smile.center

            if touchPoint.x > self.view.bounds.size.width / 2 {
                newPoint.x = 10 + self.smile.bounds.size.width / 2
            } else {
                newPoint.x = self.view.bounds.size.width - self.smile.bounds.size.width / 2 - 10
            }
            
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.smile.center = newPoint
            })
            

            
        } else if panGesture.state == UIGestureRecognizerState.Changed {
            println("changed")
        } else if panGesture.state == UIGestureRecognizerState.Ended {
            println("ended")
            
            var newPoint = self.smile.center
            newPoint.x = self.view.center.x
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.smile.center = newPoint
            })

            
        }
        
        var translation = panGesture.translationInView(self.view)
        
        var newCenter = CGPointMake(self.smile.center.x, self.smile.center.y + translation.y)
        
        if  newCenter.y - self.smile.bounds.size.height / 2 >= 0 && newCenter.y < self.view.bounds.size.height - self.smile.bounds.size.height / 2 {
            self.smile.center = newCenter
        }
        
        panGesture.setTranslation(CGPointZero, inView: self.view)
        
        updateColors()
    }
    
    func updateColors () {
        var maxTravelHeight = self.view.bounds.size.height - self.smile.bounds.size.height
        var travelBeginOffset = self.smile.bounds.size.height / 2
        
        var percentageTraveled: CGFloat = (self.smile.center.y - travelBeginOffset) / maxTravelHeight
        
        var midRed: CGFloat = 255.0/255.0
        var midGreen: CGFloat = 76.0/255.0
        var midBlue: CGFloat = 30.0/255.0
        
        if percentageTraveled < 0.5 {
            
            var percent = percentageTraveled * 2
            
            var topRed: CGFloat = 212.0/255.0
            var topGreen: CGFloat = 20.0/255.0
            var topBlue: CGFloat = 90.0/255.0
            
            var resultRed = topRed + percent * (midRed - topRed)
            var resultGreen = topGreen + percent * (midGreen - topGreen)
            var resultBlue = topBlue + percent * (midBlue - topBlue)
            
            var color = UIColor(red: resultRed, green: resultGreen, blue: resultBlue, alpha: 1.0)
            
            self.view.backgroundColor = color
            self.smile.updateStrokeColor(color)
            
        } else if percentageTraveled > 0.5 {
            
            var percent = (percentageTraveled - 0.5) * 2
            
            var bottomRed: CGFloat = 27.0/255.0
            var bottomGreen: CGFloat = 20.0/255.0
            var bottomBlue: CGFloat = 100.0/255.0
            
            var resultRed = midRed + percent * (bottomRed - midRed)
            var resultGreen = midGreen + percent * (bottomGreen - midGreen)
            var resultBlue = midBlue + percent * (bottomBlue - midBlue)
            
            var color = UIColor(red: resultRed, green: resultGreen, blue: resultBlue, alpha: 1.0)
            
            self.view.backgroundColor = color
            self.smile.updateStrokeColor(color)
            
        } else {
            var midColor = UIColor(red: midRed, green: midGreen, blue: midBlue, alpha: 1.0)
            self.view.backgroundColor = midColor
            self.smile.updateStrokeColor(midColor)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var startPoint = CGPointMake(self.view.center.x, self.smile.bounds.size.height / 2)
        
        self.smile.center = startPoint
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

