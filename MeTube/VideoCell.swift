//
//  VideoCell.swift
//  MeTube
//
//  Created by Stanley Pan on 8/30/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name, numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subtitleText = "\(channelName) • \(numberFormatter.stringFromNumber(numberOfViews)!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            // measure title text
//            if let videoTitle = video?.title {
//                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
//                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
//                let estimatedRect = NSString(string: videoTitle).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
//                
//                if estimatedRect.size.height > 16 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 20
//                }
//            }
            if let videoTitle = video?.title {
                if videoTitle.characters.count > 40 {
                    titleLabelHeightConstraint?.constant = 44
                    separatorLineViewConstraint?.constant = 36
                } else {
                    titleLabelHeightConstraint?.constant = 20
                    separatorLineViewConstraint?.constant = 16
                }
            }
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
           thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "TSBlankSpace")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "myProfileImage")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()
    
//    let separatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.rgb(230, green: 230, blue: 230)
//        
//        return view
//    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(230, green: 230, blue: 230)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    var profileImageSeparatorConstraint: String = "36"
    var separatorLineViewConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorLineView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        // Vertical Constraints
//        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-\(profileImageSeparatorConstraint)-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorLineView)
        
        thumbnailImageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 16).active = true
        userProfileImageView.topAnchor.constraintEqualToAnchor(thumbnailImageView.bottomAnchor, constant: 8).active = true
        userProfileImageView.heightAnchor.constraintEqualToConstant(44).active = true
        
        separatorLineViewConstraint = separatorLineView.topAnchor.constraintEqualToAnchor(userProfileImageView.bottomAnchor, constant: 36)
        separatorLineViewConstraint?.active = true
        
        separatorLineView.heightAnchor.constraintEqualToConstant(1).active = true
        separatorLineView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
        addConstraintsWithFormat("H:|[v0]|", views: separatorLineView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
    }
}