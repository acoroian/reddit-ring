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
    let numberOfComments : Int
    
    private enum CodingKeys: String, CodingKey {
        case title, author, date = "created_utc", thumbnailUrl = "thumbnail", numberOfComments = "num_comments"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        let timeInterval = (try container.decode(Double.self, forKey: .date))
        date = Date(timeIntervalSince1970: timeInterval)
        
        thumbnailUrl = try container.decode(String.self, forKey: .author)
        numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
    }
}
