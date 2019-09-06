//
//  URLSession+Promise.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

extension URLSession {
    func request(url: URL) -> Future<Data> {
        let promise = Promise<Data>()
        let task = dataTask(with: url) { data, _, error in
            if let error = error {
                promise.reject(with: error)
            } else {
                promise.resolve(with: data ?? Data())
            }
        }
        task.resume()
        return promise
    }
}
