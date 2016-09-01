//
//  SettingsLauncher.swift
//  MeTube
//
//  Created by Stanley Pan on 9/1/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case None = ""
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case Feedback = "Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch account"
    case Cancel = "Cancel"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackDimmedView = UIView()
    
    let settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        
        return [Setting(name: .Settings, imageName: "settings"),
                Setting(name: .TermsPrivacy, imageName: "privacy"),
                Setting(name: .Feedback, imageName: "feedback"),
                Setting(name: .Help, imageName: "help"),
                Setting(name: .SwitchAccount, imageName: "switchAccount"),
                Setting(name: .Cancel, imageName: "cancel")]
    }()
    
    var homeController: HomeController?
    
    func showSettings() {
        
        if let window = UIApplication.sharedApplication().keyWindow {
            
            blackDimmedView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackDimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackDimmedView)
            window.addSubview(settingsCollectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
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
    
    func handleDismiss(setting: Setting) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            
            self.blackDimmedView.alpha = 0
            
            if let window = UIApplication.sharedApplication().keyWindow {
                self.settingsCollectionView.frame = CGRectMake(0, window.frame.height, self.settingsCollectionView.frame.width, self.settingsCollectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            
            if setting.name != .Cancel && setting.name != .None {
                print(setting.name)
                self.homeController?.showControllerForSetting(setting)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SettingsCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
    }
    
    override init() {
        super.init()
        
        settingsCollectionView.dataSource = self
        settingsCollectionView.delegate = self
        settingsCollectionView.registerClass(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}