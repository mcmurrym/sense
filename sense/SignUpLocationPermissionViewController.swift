//
//  SignUpLocationPermissionViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpLocationPermissionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToLocation(sender: AnyObject) {
        self.performSegueWithIdentifier("toGender", sender: nil)
    }

    @IBAction func skipLocationConnection(sender: AnyObject) {
        self.performSegueWithIdentifier("toGender", sender: nil)
    }
}
