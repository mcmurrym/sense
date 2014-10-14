//
//  Health.swift
//  sense
//
//  Created by Matt McMurry on 10/13/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import Foundation
import HealthKit

class Health {

    class var sharedInstance: Health {
        struct SharedInstance {
            static let instance = Health()
        }
        
        return SharedInstance.instance
    }
    
    let health = HKHealthStore()
    let birthdayType = HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
    let biologicalSexType = HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)
    let steps = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
    
    func getPermission(completion: (Bool, NSError!) -> Void) {
        
        let readType = NSSet(array: [birthdayType, biologicalSexType, steps])
        
        health.requestAuthorizationToShareTypes(NSSet(), readTypes: readType) { (completed: Bool, error: NSError!) -> Void in
            completion(completed, error)
        }
    }
    
    func getBirthday() -> NSDate? {
        var error: NSError?
        let birthdate = health.dateOfBirthWithError(&error)
        
        return birthdate
    }
    
    func getBiologicalSex() -> String? {
        var error: NSError?
        let bilogicalSex = health.biologicalSexWithError(&error)
        
        var genderValue: String?
        
        switch (bilogicalSex.biologicalSex) {
        case HKBiologicalSex.Female:
            genderValue = "Female"
        case HKBiologicalSex.Male:
            genderValue = "Male"
        default:
            genderValue = nil
        }
        
        return genderValue
    }
    
    func getStepsSoFarToday(completion: (Double)! -> Void) {
        
        let calendar = NSCalendar.currentCalendar()
        
        let now = NSDate()
        let startOfDay = calendar.startOfDayForDate(now)
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(startOfDay, endDate: now, options:HKQueryOptions.None)
        
        let statsQuery = HKStatisticsQuery(quantityType: steps,
                                           quantitySamplePredicate: predicate,
                                           options: HKStatisticsOptions.CumulativeSum) {
                                            (query: HKStatisticsQuery!, stats: HKStatistics!, error: NSError!) -> Void in
                                                let count = stats.sumQuantity().doubleValueForUnit(HKUnit.countUnit())
                                                completion(count)
                                           }
        
    }
}