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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var pageControl: FXPageControl? = self.navigationController?.view.viewWithTag(pageControlTag) as? FXPageControl
        
        if let aPageControl = pageControl {
            aPageControl.currentPage = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToLocation(sender: AnyObject) {
        Location.sharedInstance.requestAuthorization()
        self.performSegueWithIdentifier("toGender", sender: nil)
    }

    @IBAction func skipLocationConnection(sender: AnyObject) {
        self.performSegueWithIdentifier("toGender", sender: nil)
    }
}
