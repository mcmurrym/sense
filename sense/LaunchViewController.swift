//
//  LaunchViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

@IBDesignable class LaunchViewController: UIViewController {

    var runOnce = false
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var launchImageName = ""
        
        let height = UIScreen.mainScreen().bounds.size.height
        switch (height) {
        case 667:
            launchImageName = "LaunchImage-800-667h"
        case 736:
            launchImageName = "LaunchImage-800-Portrait-736h"
        case 568:
            launchImageName = "LaunchImage-700-568h"
        default:
            launchImageName = "LaunchImage-700"
        }
        
        self.imageView.image = UIImage(named: launchImageName)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let popTime = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC))
        if !self.runOnce {
            if let user = PFUser.currentUser() {
                if let navigationController = self.navigationController {
                    dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                        DashboardViewController.showDashboardInNavigationController(navigationController)
                    })
                }
            } else {
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                    let storyBoard = UIStoryboard(name: "signin", bundle: nil)
                    self.navigationController?.pushViewController(storyBoard.instantiateInitialViewController() as UIViewController,
                        animated: true)
                })
            }
            self.runOnce = true
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
