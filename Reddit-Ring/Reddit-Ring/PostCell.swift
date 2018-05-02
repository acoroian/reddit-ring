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
    var cellImageSelected : ((_ index: Int) -> Void)?
    
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var author : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var comments : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithModel(_ model: RedditModel) {
        self.model = model

        title.text = model.data.title
        author.text = model.data.author
        comments.text = "Has \(model.data.numberOfComments) Comments"
        date.text = "Created \(model.data.date.timeAgoDisplay())"
        thumbnailImage.imageFromUrl(urlString: model.data.thumbnailUrl)
        thumbnailWidth.constant = CGFloat(model.data.thumbnailWidth)
        thumbnailHeight.constant = CGFloat(model.data.thumbnailHeight)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showFullScreenImage))
        thumbnailImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func showFullScreenImage() {
        cellImageSelected?(self.thumbnailImage.tag)
    }
}
