//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import Foundation

class RedditModel : Decodable {
    let data : PostModel
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(PostModel.self, forKey: .data)
    }
}
