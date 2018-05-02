//
//  ReditModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var data = [[TableViewCompatible]]()
    var configure : ((_ cell: UITableViewCell, _ index: IndexPath) -> Void)?
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.section][indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        configure?(cell, indexPath)
        return cell
    }
}
