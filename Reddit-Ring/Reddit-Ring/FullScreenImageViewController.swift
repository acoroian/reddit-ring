//
//  FullScreenImage.swift
//  Reddit-Ring
//
//  Created by Adrian Coroian on 5/1/18.
//  Copyright © 2018 Adrian Coroian. All rights reserved.
//

import UIKit
import WebKit

class FullScreenImageViewController : UIViewController {
    @IBOutlet weak var webView: WKWebView!
    public var photoUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: photoUrl) {
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func save() {
//        UIImageWriteToSavedPhotosAlbum(, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(photoUrl, forKey: "photoUrl")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        photoUrl = coder.decodeObject(forKey: "photoUrl") as? String ?? ""
        
        if let url = URL(string: photoUrl) {
            webView.load(URLRequest(url: url))
        }
        super.decodeRestorableState(with: coder)
    }
}
