//
//  SignUpBirthdateViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpBirthdateViewController: UIViewController {

    @IBOutlet weak var next: PillButton!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.monthTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(sender: AnyObject) {
        
        if countElements(self.monthTextField.text) > 1 &&
           countElements(self.dayTextField.text) > 1 &&
           countElements(self.yearTextField.text) > 1 {
                self.performSegueWithIdentifier("toCompensation", sender: nil)
        } else {
            self.next.bump()
        }
    }

    @IBAction func monthChanged(sender: AnyObject) {
        if countElements(self.monthTextField.text) > 1 {
            self.dayTextField.becomeFirstResponder()
        }
    }
   
    @IBAction func dayChanged(sender: AnyObject) {
        if countElements(self.dayTextField.text) > 1 {
            self.yearTextField.becomeFirstResponder()
        }
    }

    @IBAction func yearChanged(sender: AnyObject) {
    }
    
    
}
