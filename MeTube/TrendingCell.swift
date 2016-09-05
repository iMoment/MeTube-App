//
//  TrendingCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/4/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.feedCollectionView.reloadData()
        }
    }
}