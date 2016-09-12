//
//  Video.swift
//  MeTube
//
//  Created by Stanley Pan on 8/31/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(value: AnyObject?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercaseString
        
        let range = key.startIndex...key.startIndex.advancedBy(0)
        let selectorString = key.stringByReplacingCharactersInRange(range, withString: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.respondsToSelector(selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "channel" {
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeysWithDictionary(channelDictionary)
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dictionary)
    }
}

class Channel: SafeJsonObject {
    
    var name: String?
    var profile_image_name: String?
}