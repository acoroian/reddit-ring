//
//  ImageViewExtension.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            if let cachedImage = ImageCache.shared.cache.object(forKey: urlString as NSString) {
                self.image = cachedImage
            } else {
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                    guard let data = data else {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)

                        guard let savedImage = self.image else { return }
                        ImageCache.shared.cache.setObject(savedImage, forKey: urlString as NSString)
                    }
                }).resume()
            }
        }
    }
}
