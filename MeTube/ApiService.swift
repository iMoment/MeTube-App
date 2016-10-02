//
//  ApiService.swift
//  MeTube
//
//  Created by Stanley Pan on 9/2/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                if let data = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                    
                    let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                    
                    DispatchQueue.main.async(execute: {
                        completion(videos)
                    })
                }
            } catch let jsonError {
                print(jsonError)
            }
        }) .resume()
    }
}

//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//    
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//    
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//    
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//    
//    video.channel = channel
//    
//    videos.append(video)
//}
//
//dispatch_async(dispatch_get_main_queue(), {
//    completion(videos)
//})

