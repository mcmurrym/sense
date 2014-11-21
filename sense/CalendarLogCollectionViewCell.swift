//
//  CalendarLogCollectionViewCell.swift
//  sense
//
//  Created by Matt McMurry on 11/17/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class CalendarLogCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loggedImageView: UIImageView!
    func setLogged(logged: Bool) {
        if logged {
            loggedImageView.image = UIImage(named: "loggedDot")
        } else {
            loggedImageView.image = UIImage(named: "notLoggedDot")
        }
    }

}
