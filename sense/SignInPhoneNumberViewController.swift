//
//  SignInPhoneNumberViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/4/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignInPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    var phoneNumber: String?
    let verifyCode: String
    var verifyMode: Bool
    
    @IBOutlet weak var next: PillButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    let numberFormatter: NBAsYouTypeFormatter
    var previousValue: String
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        numberFormatter = NBAsYouTypeFormatter(regionCode: "US")
        previousValue = ""
        verifyCode = String(Int(arc4random_uniform(8999) + 1000))
        verifyMode = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        numberFormatter = NBAsYouTypeFormatter(regionCode: "US")
        previousValue = ""
        verifyCode = String(Int(arc4random_uniform(8999) + 1000))
        verifyMode = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.phoneNumberTextField.addTarget(self,
            action: "textFieldChanged:",
            forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldChanged(textField: UITextField) {
        if !verifyMode {
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
    }

    @IBAction func buttonTapped(sender: UIButton) {
        
        if verifyMode {
            if self.phoneNumberTextField.text == verifyCode {
                
                if let number = self.phoneNumber {
                    
                    let readyNumber = self.numberToSend(number)
                    
                    PFUser.logInWithUsernameInBackground(readyNumber, password: commonP, block: { (user: PFUser!, error: NSError!) -> Void in
                        if user == nil {
                            TemporaryUser.sharedInstance.phoneNumber = self.numberToSend(self.phoneNumber!)
                            
                            if Health.isHealthDataAvailable() {
                                self.performSegueWithIdentifier("toHealth", sender: nil)
                            } else {
                                self.performSegueWithIdentifier("toLocationFromSignIn", sender: nil)
                            }
                        } else {
                            if let navigationController = self.navigationController {
                                DashboardViewController.showDashboardInNavigationController(navigationController)
                            }
                        }
                    })
                }
            } else {
                self.next.bump()
            }
        } else {
            if self.numberValid() {
                verifyMode = true
                sendVerificationCode()
                updateUIForCodeVerification(sender)
            } else {
                self.next.bump()
            }
        }
    }
    
    func numberValid() -> Bool {
        let numberUtil = NBPhoneNumberUtil.sharedInstance()
        
        var error: NSError?
        
        let number = numberUtil.parse(self.phoneNumberTextField.text,
            defaultRegion: "US",
            error: &error)
        
        var readyNumberError: NSError?
        let readyNumber = numberUtil.format(number, numberFormat: NBEPhoneNumberFormatE164, error: &readyNumberError)
        
        if error != nil || readyNumberError != nil || countElements(readyNumber) != 12 {
            return false
        } else {
            return true
        }
    }
    
    func numberToSend(raw: String) -> String {
        let numberUtil = NBPhoneNumberUtil.sharedInstance()
        
        var error: NSError?
        
        let number = numberUtil.parse(raw,
            defaultRegion: "US",
            error: &error)
        
        var readyNumberError: NSError?
        let readyNumber = numberUtil.format(number, numberFormat: NBEPhoneNumberFormatE164, error: &readyNumberError)
        
        return readyNumber
    }
    
    func sendVerificationCode() {
        let readyNumber = numberToSend(self.phoneNumberTextField.text)
        
        PFCloud.callFunctionInBackground("smsVerify", withParameters: ["phoneNumber" : readyNumber, "verification" : verifyCode] ) {
            (resp: AnyObject!, error: NSError!) -> Void in
        }
    }
    
    func updateUIForCodeVerification(button: UIButton) {
        //change place holder text to code
        self.phoneNumberTextField.placeholder = "Code"
        
        //save, but clear phone number
        self.phoneNumber = self.phoneNumberTextField.text
        self.phoneNumberTextField.text = nil
        
        //change sign in text to verify
        button.setTitle("Verify", forState: UIControlState.Normal)
    }
}
