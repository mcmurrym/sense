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
    @IBOutlet weak var mask: LaunchBackgroundView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.mask.layer.mask = self.simpleLabel.layer
    }
    
    override func viewDidLayoutSubviews() {
        
        if !self.runOnce {
            if let user = PFUser.currentUser() {
                let storyBoard = UIStoryboard(name: "dashboard", bundle: nil)
                self.navigationController?.setViewControllers([storyBoard.instantiateViewControllerWithIdentifier("dashboard")], animated: true)
            } else {
                UIView.animateWithDuration(0.50,
                                           delay: 0.5,
                                           options: UIViewAnimationOptions.CurveEaseOut,
                                           animations: { () -> Void in
                                                self.backgroundView.alpha = 0.0
                                                self.logoImageView.alpha = 0.0
                                           }) { (completed: Bool) -> Void in
                                                var popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC));
                                                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                                                    var storyBoard = UIStoryboard(name: "signin", bundle: nil)
                                                    self.navigationController?.pushViewController(storyBoard.instantiateInitialViewController() as UIViewController, animated: true)
                                               })
                                           }
            }
            self.runOnce = true
        }
    }
}
