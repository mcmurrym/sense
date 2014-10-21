//
//  TemporaryUser.swift
//  sense
//
//  Created by Matt McMurry on 10/21/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import Foundation

class TemporaryUser {

    class var sharedInstance: TemporaryUser {
        struct SharedInstance {
            static let instance = TemporaryUser()
        }
        
        return SharedInstance.instance
    }
    
    var phoneNumber: String?
    var biologicalSex: String?
    var birthdate: NSDate?
    var compensation: String?
    
    func convertToPFUser() -> PFUser {
        let user = PFUser()

        user.username = self.phoneNumber!
        user.password = "common_8_Secret_()_Password_.:)"
        user["phoneNumber"] = user.username
        user["biologicalSex"] = self.biologicalSex!
        user["birthdate"] = self.birthdate!
        user["compensation"] = self.compensation
        user.signUpInBackground()
        
        return user
    }
}