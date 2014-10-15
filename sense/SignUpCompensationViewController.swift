//
//  SignUpCompensationViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpCompensationViewController: UIViewController {

    @IBOutlet weak var hourlyButton: UIButton!
    @IBOutlet weak var salaryButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hourlyButtonTapped(sender: AnyObject) {
        self.salaryButton.selected = false
        self.otherButton.selected = false
        self.hourlyButton.selected = !self.hourlyButton.selected
    }

    @IBAction func salaryButtonTapped(sender: AnyObject) {
        self.hourlyButton.selected = false
        self.otherButton.selected = false
        self.salaryButton.selected = !self.salaryButton.selected
    }

    @IBAction func otherButtonTapped(sender: AnyObject) {
        self.salaryButton.selected = false
        self.hourlyButton.selected = false
        self.otherButton.selected = !self.otherButton.selected
    }
    
    @IBAction func next(sender: AnyObject) {
        //sign up be done
    }
}
