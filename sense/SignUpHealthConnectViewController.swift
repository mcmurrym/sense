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
