//
//  Settings.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import Foundation

class Settings {
    
    class func isFirstLaunch() -> Bool {
        let firstLaunchKey: String = "firstLaunch"
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.registerDefaults([firstLaunchKey : true])
        
        var firstLaunch = userDefaults.boolForKey(firstLaunchKey)
        
        if firstLaunch {
            userDefaults.setBool(false, forKey: firstLaunchKey)
            userDefaults.synchronize()
        }
        
        return firstLaunch
    }
    
    
    
    

}