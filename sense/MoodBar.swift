//
//  MoodBar.swift
//  sense
//
//  Created by Matt McMurry on 11/12/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class MoodBar: UIView {
    var image: UIImageView?
    
    func setMoodBarIndex(idx: Int) {
        self.backgroundColor = [UIColor(hex: 0xFF5607), UIColor(hex: 0xEC3B39), UIColor(hex: 0xD50858), UIColor(hex: 0x77145F), UIColor(hex: 0x1B0F66)][idx]
        
        
        if let img = self.image {
            img.image = UIImage(named: "moodBar\(idx)")
        } else {
            let imageView = UIImageView(image: UIImage(named: "moodBar\(idx)")!)
            self.image = imageView
            self.addSubview(imageView)
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.size.width / 2.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowOpacity = 0.5
        
        if let img = self.image {
            var frame = img.frame
            
            if let realImage = img.image {
                frame.size = realImage.size
            }
            
            frame.origin.y = 5
            frame.origin.x = (self.bounds.size.width - frame.size.width) / 2
            
            img.frame = frame
            
        }

    }

}
