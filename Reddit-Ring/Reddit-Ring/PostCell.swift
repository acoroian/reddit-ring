//
//  PostCell.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell, Configurable {
    var model: RedditModel?
    
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var author : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var comments : UILabel!
    
    func configureWithModel(_ model: RedditModel) {
        self.model = model

        title.text = model.data.title
        author.text = model.data.author
        comments.text = String(model.data.numberOfComments)
        date.text = model.data.date.timeAgoDisplay()
        thumbnailImage.imageFromUrl(urlString: model.data.thumbnailUrl)
    }
    
    
    
}
