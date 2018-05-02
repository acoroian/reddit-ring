//
//  PostModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class PostModel : NSObject, Codable, NSCoding {
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(postId, forKey: CodingKeys.postId.description)
        aCoder.encode(title, forKey: CodingKeys.title.description)
        aCoder.encode(author, forKey: CodingKeys.author.description)
        aCoder.encode(date, forKey: CodingKeys.date.description)
        aCoder.encode(url, forKey: CodingKeys.url.description)
        aCoder.encode(thumbnailUrl, forKey: CodingKeys.thumbnailUrl.description)
        aCoder.encode(thumbnailWidth, forKey: CodingKeys.thumbnailWidth.description)
        aCoder.encode(thumbnailHeight, forKey: CodingKeys.thumbnailHeight.description)
        aCoder.encode(numberOfComments, forKey: CodingKeys.numberOfComments.description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        postId = aDecoder.decodeObject(forKey: CodingKeys.postId.description) as? String ?? ""
        title = aDecoder.decodeObject(forKey: CodingKeys.title.description) as? String ?? ""
        author = aDecoder.decodeObject(forKey: CodingKeys.author.description) as? String ?? ""
        date = aDecoder.decodeObject(forKey: CodingKeys.date.description) as? Date ?? Date()
        url = aDecoder.decodeObject(forKey: CodingKeys.url.description) as? String ?? ""
        thumbnailUrl = aDecoder.decodeObject(forKey: CodingKeys.thumbnailUrl.description) as? String ?? ""
        thumbnailWidth = aDecoder.decodeObject(forKey: CodingKeys.thumbnailWidth.description) as? Int ?? 0
        thumbnailHeight = aDecoder.decodeObject(forKey: CodingKeys.thumbnailHeight.description) as? Int ?? 0
        numberOfComments = aDecoder.decodeObject(forKey: CodingKeys.numberOfComments.description) as? Int ?? 0
    }
}
