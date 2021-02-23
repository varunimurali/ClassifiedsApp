//
//  ImageLoader.swift
//  jsonPractice1
//
//  Created by Varuni R on 2/22/21.
//

import Foundation
import UIKit

class ImageLoader {
    
    var task: URLSessionDownloadTask?
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
          //  let placeholder = #imageLiteral(resourceName: "placeholder")
//            DispatchQueue.main.async {
//                completionHandler(placeholder)
//            }
            let url: URL! = URL(string: imagePath)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task?.resume()
        }
    }
}
