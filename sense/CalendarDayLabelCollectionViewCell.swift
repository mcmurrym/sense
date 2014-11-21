//
//  CalendarDayLabelCollectionViewCell.swift
//  sense
//
//  Created by Matt McMurry on 11/17/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class CalendarDayLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    func setDayLabelFromIndex(index: Int) {
        switch (index) {
        case 0:
            dayLabel.text = "M"
        case 1:
            dayLabel.text = "T"
        case 2:
            dayLabel.text = "W"
        case 3:
            dayLabel.text = "T"
        case 4:
            dayLabel.text = "F"
        case 5:
            dayLabel.text = "S"
        case 6:
            dayLabel.text = "S"
        default:
            dayLabel.text = "D"
        }
    }

}
