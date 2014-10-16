//
//  SignUpCompensationViewController.swift
//  sense
//
//  Created by Matt McMurry on 10/14/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import UIKit

class SignUpCompensationViewController: UIViewController {

    @IBOutlet weak var hourlyButton: UIButton!
    @IBOutlet weak var salaryButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var next: PillButton!
    var pageControl: FXPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pageControl = self.navigationController?.view.viewWithTag(pageControlTag) as? FXPageControl
        
        if let aPageControl = pageControl {
            aPageControl.currentPage = 4
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let aPageControl = self.pageControl {
            UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                aPageControl.alpha = 0.0
            }, completion: { (completed: Bool) -> Void in
                aPageControl.removeFromSuperview()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hourlyButtonTapped(sender: AnyObject) {
        self.salaryButton.selected = false
        self.otherButton.selected = false
        self.hourlyButton.selected = !self.hourlyButton.selected
    }

    @IBAction func salaryButtonTapped(sender: AnyObject) {
        self.hourlyButton.selected = false
        self.otherButton.selected = false
        self.salaryButton.selected = !self.salaryButton.selected
    }

    @IBAction func otherButtonTapped(sender: AnyObject) {
        self.salaryButton.selected = false
        self.hourlyButton.selected = false
        self.otherButton.selected = !self.otherButton.selected
    }
    
    @IBAction func next(sender: AnyObject) {
        if !self.salaryButton.selected && !self.hourlyButton.selected && !self.otherButton.selected {
            self.next.bump()
        } else {
            let storyBoard = UIStoryboard(name: "dashboard", bundle: nil)
            self.navigationController?.setViewControllers([storyBoard.instantiateViewControllerWithIdentifier("dashboard")], animated: true)
        }
    }
}
