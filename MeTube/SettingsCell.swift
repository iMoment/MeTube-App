//
//  SettingsCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/1/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            featureLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            featureLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let featureLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(featureLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-12-[v0(30)]-24-[v1]|", views: iconImageView, featureLabel)
        addConstraintsWithFormat("V:|[v0]|", views: featureLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
