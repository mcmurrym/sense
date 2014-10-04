//
//  LaunchViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var labelTranslateDistance = self.view.bounds.size.width - self.simpleLabel.frame.origin.x
        
        var labelTranslate = CGAffineTransformMakeTranslation(labelTranslateDistance, 0)
        
        self.simpleLabel.transform = labelTranslate
        
        UIView.animateWithDuration(0.50,
            delay: 0.2,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                self.simpleLabel.transform = CGAffineTransformIdentity
                
                self.logoImageView.alpha = 0.0
            }) { (completed: Bool) -> Void in
            
                var popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                    var storyBoard = UIStoryboard(name: "signin", bundle: nil)
                    self.navigationController?.pushViewController(storyBoard.instantiateInitialViewController() as UIViewController, animated: true)
                })
        }
    }
}
