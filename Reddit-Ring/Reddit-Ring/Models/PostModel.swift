//
//  PostModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class PostModel : NSObject, Codable {
    let postId : String
    let title : String
    let author : String
    let date : Date
    let url : String
    let thumbnailUrl : String
    let thumbnailWidth : Int
    let thumbnailHeight : Int
    let numberOfComments : Int
    
    private enum CodingKeys: String, CodingKey {
        case postId = "subreddit_id", title, author, date = "created_utc", url, thumbnailUrl = "thumbnail", thumbnailWidth = "thumbnail_width", thumbnailHeight = "thumbnail_height", numberOfComments = "num_comments"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        postId = try container.decode(String.self, forKey: .postId)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        let timeInterval = (try container.decode(Double.self, forKey: .date))
        date = Date(timeIntervalSince1970: timeInterval)
        
        url = try container.decode(String.self, forKey: .url)
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        if let thumbnailWidth = try? container.decode(Int.self, forKey: .thumbnailWidth) {
            self.thumbnailWidth = thumbnailWidth
        } else { self.thumbnailWidth = 0 }
        if let thumbnailHeight = try? container.decode(Int.self, forKey: .thumbnailHeight) {
            self.thumbnailHeight = thumbnailHeight
        } else { self.thumbnailHeight = 0 }
        
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(title, forKey: .title)
        try container.encode(author, forKey: .author)
        try container.encode(url, forKey: .url)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode(thumbnailWidth, forKey: .thumbnailWidth)
        try container.encode(thumbnailHeight, forKey: .thumbnailHeight)
        try container.encode(numberOfComments, forKey: .numberOfComments)
    }
}
