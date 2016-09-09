//
//  Video.swift
//  MeTube
//
//  Created by Stanley Pan on 8/31/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
}

class Channel: NSObject {
    
    var name: String?
    var profile_image_name: String?
}