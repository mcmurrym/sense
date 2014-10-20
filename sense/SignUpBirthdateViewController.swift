//
//  SignUpBirthdateViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpBirthdateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var next: PillButton!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.monthTextField.becomeFirstResponder()
        
        var pageControl: FXPageControl? = self.navigationController?.view.viewWithTag(pageControlTag) as? FXPageControl
        
        if let aPageControl = pageControl {
            aPageControl.currentPage = 3
        }
    }

    @IBAction func next(sender: AnyObject) {
        
        if countElements(self.monthTextField.text) > 0 &&
           countElements(self.dayTextField.text) > 0 &&
           countElements(self.yearTextField.text) > 0 {
            
            let dateString = "\(self.monthTextField.text)-\(self.dayTextField.text)-\(self.yearTextField.text)"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            
            var date: NSDate? = dateFormatter.dateFromString(dateString)
            
            if let hasDate = date {
                self.performSegueWithIdentifier("toCompensation", sender: nil)
            } else {
                self.next.bump()
            }
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
        if countElements(self.yearTextField.text) > 1 {
            self.yearTextField.resignFirstResponder()
        }
    }
    
    //MARK: - UITextField Delegate
    func textFieldDidEndEditing(textField: UITextField) {
        if countElements(textField.text) == 1 {
            textField.text = "0\(textField.text)"
        }
    }
    
}
