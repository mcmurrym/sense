//
//  ViewController.swift
//  fleezy-smile
//
//  Created by Matt McMurry on 9/23/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class MoodLogViewController: UIViewController {

    @IBOutlet weak var howAreYouLabel: UILabel!
    var smile: EmotionView = EmotionView(frame: CGRectMake(0, 0, 122, 122))
    var smileLabel: UILabel?
    var labelOptions: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.smile.hidden = true
        self.smile.opaque = false
        self.view.addSubview(self.smile)
        self.smile.centerOffset = 40
        
        var pan = UIPanGestureRecognizer(target: self, action: "panned:")
        self.view.addGestureRecognizer(pan)
        
        self.labelOptions = ["Pretty dang good", "Feeling good", "Meh", "Today is the worst!"]
        
        self.smileLabel = UILabel()
        self.smileLabel?.font = UIFont(name: "Roboto-Light", size: 33.0)
        self.smileLabel?.textColor = UIColor.whiteColor()
        self.smileLabel?.textAlignment = NSTextAlignment.Center
        self.smileLabel?.text = self.labelOptions![0]
        self.smileLabel?.alpha = 0.0
        self.smileLabel?.sizeToFit()
        self.view.addSubview(self.smileLabel!)

        updateColors()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var startPoint = CGPointMake(self.view.center.x, self.view.bounds.size.height / 2)
        
        self.smile.center = startPoint
        
        self.smile.hidden = false
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.updateColors()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelLogging(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - panhandling
    
    func panned(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == UIGestureRecognizerState.Began {
            
            self.smileLabel?.alpha = 0.0
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.howAreYouLabel.alpha = 0.0

            })
            
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
//            println("changed")
        } else if panGesture.state == UIGestureRecognizerState.Ended {
            var newPoint = self.smile.center
            newPoint.x = self.view.center.x
            self.smileLabel?.text = self.currentSmileLabelValue()
            self.smileLabel?.sizeToFit()
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.smile.center = newPoint
                self.smileLabel?.alpha = 1.0
            })
        }
        
        var translation = panGesture.translationInView(self.view)
        
        var newCenter = CGPointMake(self.smile.center.x, self.smile.center.y + translation.y)
        
        if  newCenter.y - self.smile.bounds.size.height / 2 >= 0 && newCenter.y < self.view.bounds.size.height - self.smile.bounds.size.height / 2 - 40 {
            self.smile.center = newCenter
            
            var labelCenter = newCenter
            labelCenter.y += 80
            
            self.smileLabel?.center = labelCenter
        }
        
        panGesture.setTranslation(CGPointZero, inView: self.view)
        
        updateColors()
    }
    
    func currentSmileLabelValue() -> String {
        var percentageTraveled = self.percentageTraveled()
        
        var smileText = self.labelOptions![0]
        
        if percentageTraveled > 0.25 && percentageTraveled < 0.50 {
            smileText = self.labelOptions![1]
        } else if percentageTraveled > 0.50 && percentageTraveled < 0.75 {
            smileText = self.labelOptions![2]
        } else if percentageTraveled > 0.75 {
            smileText = self.labelOptions![3]
        }
        
        return smileText
    }
    
    func percentageTraveled() -> CGFloat {
        var maxTravelHeight = self.view.bounds.size.height - self.smile.bounds.size.height
        var travelBeginOffset = self.smile.bounds.size.height / 2
        
        var percentageTraveled: CGFloat = (self.smile.center.y - travelBeginOffset) / maxTravelHeight
        
        return percentageTraveled
    }
    
    //MARK: - color updates
    
    func updateColors () {
        var percentageTraveled = self.percentageTraveled()
        
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
}

