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
        // Do any additional setup after loading the view, typically from a nib.
        
        (self.tableView.delegate as! TableViewDelegate).shouldLoadMore = { index in
            self.viewModel.shouldLoadMore(currentIndex: index)
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

    
}

