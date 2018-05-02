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

extension TableViewDataSource : UIDataSourceModelAssociation {
    func modelIdentifierForElement(at idx: IndexPath, in view: UIView) -> String? {
        return self.data[idx.section][idx.row].uniqueIdentifier
    }
    
    func indexPathForElement(withModelIdentifier identifier: String, in view: UIView) -> IndexPath? {
        for section in data {
            for (index, item) in section.enumerated() {
                if item.uniqueIdentifier == identifier {
                    return IndexPath(row: index, section: 0)
                }
            }
        }
        
        return IndexPath(row: 0, section: 0)
    }
}
