//
//  SignUpHealthConnectViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/10/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit


class SignUpHealthConnectViewController: UIViewController {

    @IBOutlet weak var laterButton: PillButton!
    @IBOutlet weak var connectButton: PillButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var healthIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.healthIcon.layer.shadowColor = UIColor.blackColor().CGColor
        self.healthIcon.layer.shadowOffset = CGSizeMake(0, 4)
        self.healthIcon.layer.shadowOpacity = 0.3
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageControl = FXPageControl(frame: CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 20))
        pageControl.dotSpacing = 40
        pageControl.dotImage = UIImage(named: "strokeDot")
        pageControl.selectedDotImage = UIImage(named: "fillDot")
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.alpha = 0.0
        self.navigationController?.view.addSubview(pageControl)
        
        UIView.animateWithDuration(0.15,
                                   delay: 0.15,
                                   options: UIViewAnimationOptions.allZeros,
                                   animations: { () -> Void in
                                        pageControl.alpha = 1.0
                                   },
                                   completion: nil)
        
//        UIView.animateWithDuration(0.15, animations: { () -> Void in
//            pageControl.alpha = 1.0
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToHealth(sender: AnyObject) {
        self.connectButton.enabled = false
        self.laterButton.enabled = false
        
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        Health.sharedInstance.getPermission { (completed: Bool, error: NSError!) -> Void in
            self.activityIndicator.stopAnimating()
            if completed {
                self.performSegueWithIdentifier("toLocation", sender: nil)
            } else {
                self.connectButton.enabled = true
                self.laterButton.enabled = true
            }
        }
    }

    @IBAction func skipHealthConnection(sender: AnyObject) {
        self.performSegueWithIdentifier("toLocation", sender: nil)
    }
}
