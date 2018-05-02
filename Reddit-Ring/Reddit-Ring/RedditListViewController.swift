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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.tableView.delegate as! TableViewDelegate).shouldLoadMore = { index in
            self.viewModel.shouldLoadMore(currentIndex: index)
        }
        
        (self.tableView.delegate as! TableViewDelegate).selectedCell = { index in
            self.tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
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

    func loadImageFullScreen(notification: NSNotification) {
        self.performSegue(withIdentifier: "showImage", sender: self)
    }
    
}

