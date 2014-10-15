//
//  Location.swift
//  sense
//
//  Created by Matt McMurry on 10/15/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import Foundation

class Location {
    
    let locationManager: CLLocationManager
    
    class var sharedInstance: Location {
        struct SharedInstance {
            static let instance = Location()
        }
        
        return SharedInstance.instance
    }
    
    init () {
        self.locationManager = CLLocationManager()
    }
    
    func requestAuthorization() {
        if CLLocationManager.locationServicesEnabled() &&
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            
                if self.locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")) {
                    self.locationManager.requestWhenInUseAuthorization()
                } else {
                    self.locationManager.startUpdatingLocation()
                    self.locationManager.stopUpdatingLocation()
                }
        }
    }
}