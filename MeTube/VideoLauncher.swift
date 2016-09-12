//
//  VideoLauncher.swift
//  MeTube
//
//  Created by Stanley Pan on 9/12/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation.")
        
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.redColor()
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { 
                
                view.frame = keyWindow.frame
                
                }, completion: { (completedAnimation) in
                    // We'll do something here later
            })
        }
    }
}