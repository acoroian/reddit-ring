//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class RedditModel : NSObject, Codable, NSCoding {

    let data : PostModel?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode(PostModel.self, forKey: .data)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(data, forKey: CodingKeys.data.description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObject(forKey: CodingKeys.data.description) as? PostModel
    }
}

extension RedditModel : TableViewCompatible {
    var uniqueIdentifier: String {
        return data?.postId ?? ""
    }
    
    var reuseIdentifier: String {
        return "PostCellIdentifier"
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! PostCell
        cell.configureWithModel(self)
        return cell
    }
}
