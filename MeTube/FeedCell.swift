//
//  FeedCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/4/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    var videos: [Video]?
    
    let cellId = "cellId"
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            
            self.videos = videos
            self.feedCollectionView.reloadData()
        }
    }

    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        backgroundColor = UIColor.brown
        
        addSubview(feedCollectionView)
        addConstraintsWithFormat("H:|[v0]|", views: feedCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: feedCollectionView)
        
        feedCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Videos are normally 16:9
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}














