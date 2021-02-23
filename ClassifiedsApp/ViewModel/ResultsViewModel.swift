//
//  ResultsViewModel.swift
//  jsonPractice1
//
//  Created by Varuni R on 2/22/21.
//

import Foundation
import UIKit

final class ResultsViewModel{
    var products = [Products]()
    var imageLoader = ImageLoader()
    
    
    func getImageWithURL(imageURL: String, completionHandler:  @escaping ((UIImage) -> ())) {
        imageLoader.obtainImageWithPath(imagePath: imageURL) { (image: UIImage) in
            completionHandler(image)
        }
    }

    func fetchProductsList(completionHandler: @escaping ((_ completed: Bool) -> Void)) {
        NetworkHandler.callService() { (data, error) in
            if error != nil {
                completionHandler(false)
            }
            self.handleAPIResponse(data: data) { (completed) in
                if completed {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    func handleAPIResponse(data:Data?, completionHandler: ((_ completed: Bool) -> Void)) {
        do {
            let json = try JSONDecoder().decode(Results.self, from: data!)
            print("JSON.....**\(json)")
            products = json.results
            completionHandler(true)
        } catch {
            print("Error during JSON decoding: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}
