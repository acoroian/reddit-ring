//
//  PostModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class PostModel : Decodable {
    let title : String
    let author : String
    let date : Date
    let thumbnailUrl : String
    let thumbnailWidth : Int
    let thumbnailHeight : Int
    let numberOfComments : Int
    
    private enum CodingKeys: String, CodingKey {
        case title, author, date = "created_utc", thumbnailUrl = "thumbnail", thumbnailWidth = "thumbnail_width", thumbnailHeight = "thumbnail_height", numberOfComments = "num_comments"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        let timeInterval = (try container.decode(Double.self, forKey: .date))
        date = Date(timeIntervalSince1970: timeInterval)
        
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        if let thumbnailWidth = try? container.decode(Int.self, forKey: .thumbnailWidth) {
            self.thumbnailWidth = thumbnailWidth
        } else { self.thumbnailWidth = 0 }
        if let thumbnailHeight = try? container.decode(Int.self, forKey: .thumbnailHeight) {
            self.thumbnailHeight = thumbnailHeight
        } else { self.thumbnailHeight = 0 }
        
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
    }
}
