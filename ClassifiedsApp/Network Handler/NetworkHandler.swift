//
//  NetworkHandler.swift
//  jsonPractice1
//
//  Created by Varuni R on 2/22/21.
//

import Foundation

struct NetworkHandler {
    typealias ServiceResponse = (Data?, Error?) -> Void

    static func callService( _ completion: @escaping ServiceResponse) {
        let baseURL = Service.baseURL
        let session = URLSession.shared
        let url = URL(string: baseURL)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        })
        task.resume()
    }
}

struct Service {
    static let baseURL = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
}
