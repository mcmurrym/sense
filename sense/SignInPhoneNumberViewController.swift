//
//  SignInPhoneNumberViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/4/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignInPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    let numberFormatter: NBAsYouTypeFormatter
    var previousValue: String
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        numberFormatter = NBAsYouTypeFormatter(regionCode: "US")
        previousValue = ""
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        numberFormatter = NBAsYouTypeFormatter(regionCode: "US")
        previousValue = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.phoneNumberTextField.addTarget(self,
            action: "textFieldChanged:",
            forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldChanged(textField: UITextField) {
        
        var textFieldLength = countElements(textField.text)
        
        if textFieldLength > countElements(self.previousValue) {
            
            var last: String = textField.text.substringFromIndex(textFieldLength-1)
            
            self.phoneNumberTextField.text = numberFormatter.inputDigit(last)
        } else if countElements(textField.text) < countElements(self.previousValue) {
            
            var newString = textField.text.stringByDeletingLastPathComponent
            self.phoneNumberTextField.text = self.numberFormatter.removeLastDigit()
        }
        self.previousValue = self.phoneNumberTextField.text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
