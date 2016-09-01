//
//  SettingsCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/1/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            featureLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let featureLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        
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
        
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, featureLabel)
        addConstraintsWithFormat("V:|[v0]|", views: featureLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }
}