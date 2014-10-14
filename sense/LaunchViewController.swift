//
//  LaunchViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    var runOnce = false
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundView: LaunchBackgroundView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

        
//        var labelTranslateDistance = self.view.bounds.size.width - self.simpleLabel.frame.origin.x
//        
//        var labelTranslate = CGAffineTransformMakeTranslation(labelTranslateDistance, 0)
//        
//        self.simpleLabel.transform = labelTranslate
        
//        self.simpleLabel.alpha = 0.0
//        UIView.animateWithDuration(0.50,
//            delay: 0.2,
//            options: UIViewAnimationOptions.CurveEaseOut,
//            animations: { () -> Void in
////                self.simpleLabel.transform = CGAffineTransformIdentity
//        
//                self.simpleLabel.alpha = 1.0
//                self.logoImageView.alpha = 0.0
//            }) { (completed: Bool) -> Void in
//            
////                var popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC));
////                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
////                    var storyBoard = UIStoryboard(name: "signin", bundle: nil)
////                    self.navigationController?.pushViewController(storyBoard.instantiateInitialViewController() as UIViewController, animated: true)
////                })
//        }
    }
    
    override func viewDidLayoutSubviews() {
        
        if !self.runOnce {
        
            UIView.animateWithDuration(0.50,
                                       delay: 0.2,
                                       options: UIViewAnimationOptions.CurveEaseOut,
                                       animations: { () -> Void in
                                            self.backgroundView.layer.mask = self.simpleLabel.layer
                                            self.logoImageView.alpha = 0.0
                                       }) { (completed: Bool) -> Void in
                                            var popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC));
                                            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                                                var storyBoard = UIStoryboard(name: "signin", bundle: nil)
                                                self.navigationController?.pushViewController(storyBoard.instantiateInitialViewController() as UIViewController, animated: true)
                                           })
                                       }
            self.runOnce = true
        }
    }
}
