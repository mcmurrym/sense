//
//  SignUpGenderViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpGenderViewController: UIViewController {

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var next: PillButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var pageControl: FXPageControl? = self.navigationController?.view.viewWithTag(pageControlTag) as? FXPageControl
        
        if let aPageControl = pageControl {
            aPageControl.currentPage = 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleButtonTap(sender: AnyObject) {
        
        if self.femaleButton.selected {
            self.femaleButton.selected = false
        }
        
        self.maleButton.selected = !self.maleButton.selected        
    }

    @IBAction func femaleButtonTap(sender: AnyObject) {

        if self.maleButton.selected {
            self.maleButton.selected = false
        }
        
        self.femaleButton.selected = !self.femaleButton.selected
    }
    
    @IBAction func next(sender: AnyObject) {
        
        if !self.maleButton.selected && !self.femaleButton.selected {
            self.next.bump()
        } else {
            
            let user = PFUser.currentUser()
            if self.maleButton.selected {
                user["biologicalSex"] = "Male"
            } else {
                user["biologicalSex"] = "Female"
            }
            
            user.saveEventually()
            
            if let birthdate: NSDate = user["birthdate"] as? NSDate {
                self.performSegueWithIdentifier("toCompensation", sender: nil)
            } else {
                self.performSegueWithIdentifier("toBirthdate", sender: nil)
            }
        }
    }
    
}
