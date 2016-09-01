//
//  SettingsLauncher.swift
//  MeTube
//
//  Created by Stanley Pan on 9/1/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackDimmedView = UIView()
    
    let settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
    }()
    
    func showSettings() {
        // TODO: Show menu
        if let window = UIApplication.sharedApplication().keyWindow {
            
            
            blackDimmedView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackDimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackDimmedView)
            window.addSubview(settingsCollectionView)
            
            let height: CGFloat = 300
            let yValue = window.frame.height - height
            settingsCollectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            
            blackDimmedView.frame = window.frame
            blackDimmedView.alpha = 0
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                self.blackDimmedView.alpha = 1
                
                self.settingsCollectionView.frame = CGRectMake(0, yValue, self.settingsCollectionView.frame.width, self.settingsCollectionView.frame.height)
                }, completion: nil)
        }
        
    }
    
    func handleDismiss() {
        UIView.animateWithDuration(0.5) {
            self.blackDimmedView.alpha = 0
            
            if let window = UIApplication.sharedApplication().keyWindow {
                self.settingsCollectionView.frame = CGRectMake(0, window.frame.height, self.settingsCollectionView.frame.width, self.settingsCollectionView.frame.height)
            }
        }
    }
    
    override init() {
        super.init()
    }
}





