//
//  SignUpHealthConnectViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/10/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit


class SignUpHealthConnectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToHealth(sender: AnyObject) {
        Health.sharedInstance.getPermission { (completed: Bool, error: NSError!) -> Void in
            
        }
        
    }

    @IBAction func skipHealthConnection(sender: AnyObject) {
        
        
    }
}
