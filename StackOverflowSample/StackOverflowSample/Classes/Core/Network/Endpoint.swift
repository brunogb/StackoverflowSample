//
//  Endpoint.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

struct StackOverflowEndpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.stackexchange.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
}


