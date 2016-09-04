//
//  FeedCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/4/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        
        return collectionView
    }()
    
    let cellId = "cellId"

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.brownColor()
        
        addSubview(feedCollectionView)
        addConstraintsWithFormat("H:|[v0]|", views: feedCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: feedCollectionView)
        
        feedCollectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }

}
