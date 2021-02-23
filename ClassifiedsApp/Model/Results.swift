//
//  Results.swift
//  jsonPractice1
//
//  Created by Varuni R on 2/22/21.
//

import Foundation

struct Results: Decodable {
    let results: [Products]
    init(results: [Products]) {
        self.results = results
    }
}

struct Products:Decodable {
    let price: String
    let name: String
    let created_at : String
    let image_urls : [String]
    let image_urls_thumbnails : [String]
 
    init(name: String, price: String, created_at: String, image_urls: [String],image_urls_thumbnails : [String] ){
        self.price = price
        self.name = name
        self.created_at = created_at
        self.image_urls = image_urls
        self.image_urls_thumbnails = image_urls_thumbnails
    }
}
