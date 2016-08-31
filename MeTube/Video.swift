//
//  Video.swift
//  MeTube
//
//  Created by Stanley Pan on 8/31/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}