//
//  RedditViewModel.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class RedditViewModel {
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    let sourceUrlString = "https://www.reddit.com/top.json?after="
    
    var redditPosts : [RedditModel] = []
    var nextDataId : String?
    
    var dataUpdated : (() -> Void)?
    
    init() {
        refreshData()
    }
    
    func refreshData() {
        self.nextDataId = ""
        self.redditPosts = []
        loadData()
    }
    
    func shouldLoadMore(currentIndex: Int) {
        if redditPosts.count - 1 == currentIndex {
            loadData()
        }
    }
    
    func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let sourceUrl = URL(string: "\(sourceUrlString)\(nextDataId ?? "")")
        let request = URLRequest(url: sourceUrl!)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if data != nil {

                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> else {
                        throw JSONError.ConversionFailed
                    }
                    
                    guard let dataDictionary = json["data"] as? [String : Any] else {
                        throw JSONError.ConversionFailed
                    }
                    
                    self.nextDataId = dataDictionary["after"] as? String
                    
                    guard let jsonPostsArray = dataDictionary["children"] else {
                        throw JSONError.ConversionFailed
                    }
                    
                    let postsData = try JSONSerialization.data(withJSONObject: jsonPostsArray) 
                    
                    let jsonDecoder = JSONDecoder()
                    guard let redditPosts = try jsonDecoder.decode([RedditModel].self, from: postsData) as? [RedditModel] else {
                        throw JSONError.ConversionFailed
                    }

                    DispatchQueue.main.async {
                        self.redditPosts.append(contentsOf: redditPosts)
                        self.dataUpdated?()
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }).resume()
    }
}
