//
//  LaunchViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/2/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLaunchImage()
        
    }


    func setupLaunchImage() {
        var launchImage: String
        
        var height: CGFloat = UIScreen.mainScreen().bounds.size.height

        switch height {
        case 667.0:
            launchImage = "LaunchImage-800-667h"
        case 736.0:
            launchImage = "LaunchImage-800-Portrait-736h"
        case 568.0:
            launchImage = "LaunchImage-700-568h"
        default:
            launchImage = "LaunchImage-700"
        }
        
        var image = UIImage(named: launchImage)
        
        self.imageView.image = image
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupLaunchImage()
    }
}
