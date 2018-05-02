//
//  ViewController.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class RedditListViewController: UITableViewController {

    let viewModel = RedditViewModel()
    var currentSelectedImage : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()


        (self.tableView.delegate as! TableViewDelegate).shouldLoadMore = { index in
            self.viewModel.shouldLoadMore(currentIndex: index)
        }
        
        (self.tableView.delegate as! TableViewDelegate).selectedCell = { index in
            self.tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
        }

        (self.tableView.dataSource as! TableViewDataSource).configure = { cell, indexPath in
            if let cell = cell as? PostCell  {
                cell.thumbnailImage.tag = indexPath.row
                cell.cellImageSelected = { index in
                    self.currentSelectedImage = self.viewModel.redditPosts[index].data?.url ?? ""
                    self.performSegue(withIdentifier: "toPhoto", sender: self)
                }
            }
        }

        viewModel.dataUpdated = {
            (self.tableView.dataSource as! TableViewDataSource).data = []
            (self.tableView.dataSource as! TableViewDataSource).data.append(self.viewModel.redditPosts)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhoto" {
            if let destinationVC = segue.destination as? FullScreenImageViewController {
                destinationVC.photoUrl = self.currentSelectedImage
            }
        }
    }

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)

        coder.encode(viewModel.redditPosts, forKey: "posts")
        coder.encode(viewModel.nextDataId, forKey: "nextDataId")
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        viewModel.redditPosts = coder.decodeObject(forKey: "posts") as? [RedditModel] ?? []
        viewModel.nextDataId = coder.decodeObject(forKey: "nextDataId") as? String

        self.tableView.reloadData()
    }
}

extension RedditListViewController : UIDataSourceModelAssociation {
    func modelIdentifierForElement(at idx: IndexPath, in view: UIView) -> String? {
       return self.viewModel.redditPosts[idx.row].data?.postId
    }

    func indexPathForElement(withModelIdentifier identifier: String, in view: UIView) -> IndexPath? {
        let postsFiltered = self.viewModel.redditPosts.filter { $0.data?.postId == identifier }
        if let filteredItem = postsFiltered.first {
            let index = self.viewModel.redditPosts.index(of: filteredItem) ?? 0
            return IndexPath(row: index, section: 0)
        }

        return IndexPath(row: 0, section: 0)
    }
}
