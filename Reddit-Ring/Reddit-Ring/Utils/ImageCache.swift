//
//  ImageCache.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    let cache = NSCache<NSString, UIImage>()
    
    init() {

    }
}
