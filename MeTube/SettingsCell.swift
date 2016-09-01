//
//  SettingsCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/1/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    override var highlighted: Bool {
        didSet {
            backgroundColor = highlighted ? UIColor.darkGrayColor() : UIColor.whiteColor()
            featureLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            iconImageView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.darkGrayColor()
        }
    }
    
    var setting: Setting? {
        didSet {
            featureLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysTemplate)
                iconImageView.tintColor = UIColor.darkGrayColor()
            }
        }
    }
    
    let featureLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFontOfSize(16)
        
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(featureLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-12-[v0(30)]-24-[v1]|", views: iconImageView, featureLabel)
        addConstraintsWithFormat("V:|[v0]|", views: featureLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }
}