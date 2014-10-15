//
//  SharedUIView.swift
//  sense
//
//  Created by Matt McMurry on 10/15/14.
//  Copyright (c) 2014 O. C. Tanner. All rights reserved.
//

import Foundation

extension UIView {
    func bump() {
        let duration: NSTimeInterval = 0.35
        let frames = 4.0
        let frameDuration: NSTimeInterval = duration / frames
        
        UIView.animateKeyframesWithDuration(duration,
            delay: 0.0,
            options: UIViewKeyframeAnimationOptions.BeginFromCurrentState,
            animations: { () -> Void in
                UIView.addKeyframeWithRelativeStartTime(0 * frameDuration,
                    relativeDuration: frameDuration,
                    animations: { () -> Void in
                        self.transform = CGAffineTransformMakeTranslation(-4, 0)
                })
                UIView.addKeyframeWithRelativeStartTime(1 * frameDuration,
                    relativeDuration: frameDuration,
                    animations: { () -> Void in
                        self.transform = CGAffineTransformMakeTranslation(5, 0)
                })
                UIView.addKeyframeWithRelativeStartTime(2 * frameDuration,
                    relativeDuration: frameDuration,
                    animations: { () -> Void in
                        self.transform = CGAffineTransformMakeTranslation(-2, 0)
                })
                UIView.addKeyframeWithRelativeStartTime(3 * frameDuration,
                    relativeDuration: frameDuration,
                    animations: { () -> Void in
                        self.transform = CGAffineTransformMakeTranslation(0, 0)
                })
            }) { (completed: Bool) -> Void in
                
                
        }
    }
}