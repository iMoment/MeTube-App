//
//  SubscriptionCell.swift
//  MeTube
//
//  Created by Stanley Pan on 9/5/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.feedCollectionView.reloadData()
        }
    }
}