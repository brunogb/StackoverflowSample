//
//  NetworkStackOverflowAPI.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case missingURL
}

class NetworkStackOverflowAPI: StackOverflowAPI {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchTopUsers()-> Future<[StackOverflowUser]> {
        
        struct TopUserResponse: Decodable {
            let items: [StackOverflowUser]
        }
        
        let endpoint = StackOverflowEndpoint(path: "/2.2/users", queryItems: [
            URLQueryItem(name: "pagesize", value: "20"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "reputation"),
            URLQueryItem(name: "site", value: "stackoverflow")
        ])
        
        let future: Future<TopUserResponse> = request(endpoint: endpoint)
        return future.map({ $0.items })
    }
    
    func fetchAvatar(from url: URL) -> Future<UIImage?> {
        return session.request(url: url).map({ UIImage(data: $0) })
    }
    
    func request<T: Decodable>(endpoint: StackOverflowEndpoint)-> Future<T> {
        guard let url = endpoint.url else {
            let promise = Promise<T>()
            promise.reject(with: NetworkError.missingURL)
            return promise
        }
        return session.request(url: url).decoded()
    }
    
}
