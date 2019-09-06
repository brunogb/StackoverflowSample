//
//  Future+Decodable.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

extension Future where Value == Data {
    
    func decoded<T: Decodable>()-> Future<T> {
        let promise = Promise<T>()
        observe { result in
            switch result {
            case let .failure(error):
                promise.reject(with: error)
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(T.self, from: data)
                    promise.resolve(with: decodedValue)
                }
                catch {
                    promise.reject(with: error)
                }
            }
        }
        return promise
    }
    
}
