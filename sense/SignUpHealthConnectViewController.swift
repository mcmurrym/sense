//
//  SignUpHealthConnectViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/10/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit


class SignUpHealthConnectViewController: UIViewController {

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
        Health.sharedInstance.getPermission { (completed: Bool, error: NSError!) -> Void in
            if completed {
                self.performSegueWithIdentifier("toLocation", sender: nil)
            }
        }
    }

    @IBAction func skipHealthConnection(sender: AnyObject) {
        self.performSegueWithIdentifier("toLocation", sender: nil)
    }
}
