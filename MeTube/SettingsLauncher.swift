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
        collectionView.backgroundColor = UIColor.white
        
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
        
        if let window = UIApplication.shared.keyWindow {
            
            blackDimmedView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackDimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackDimmedView)
            window.addSubview(settingsCollectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let yValue = window.frame.height - height
            settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackDimmedView.frame = window.frame
            blackDimmedView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackDimmedView.alpha = 1
                self.settingsCollectionView.frame = CGRect(x: 0, y: yValue, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
                
                }, completion: nil)
        }
    }
    
    func handleDismiss(_ setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackDimmedView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            
            if setting.name != .Cancel && setting.name != .None {
                print(setting.name)
                self.homeController?.showControllerForSetting(setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        let setting = settings[(indexPath as NSIndexPath).item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[(indexPath as NSIndexPath).item]
        handleDismiss(setting)
    }
    
    override init() {
        super.init()
        
        settingsCollectionView.dataSource = self
        settingsCollectionView.delegate = self
        settingsCollectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
