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
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }).resume()
        }
    }
}
