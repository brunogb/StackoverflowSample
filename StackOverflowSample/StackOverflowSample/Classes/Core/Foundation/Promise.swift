//
//  Promise.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

class Promise<Value>: Future<Value> {
    init(value: Value? = nil) {
        super.init()
        result = value.map({ (value) -> Result<Value, Error> in
            .success(value)
        })
    }
    
    func resolve(with value: Value) {
        result = .success(value)
    }
    
    func reject(with error: Error) {
        result = .failure(error)
    }
}
