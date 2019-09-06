//
//  Future+Then.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

enum FutureMapErrors: Error {
    case missingValue
}

extension Future {
    
    func map<NextValue>(_ closure: @escaping (Value) throws -> NextValue)-> Future<NextValue> {
        let promise = Promise<NextValue>()
        observe { result in
            switch result {
            case let .success(value):
                do {
                    let nextValue = try closure(value)
                    promise.resolve(with: nextValue)
                }
                catch {
                    promise.reject(with: error)
                }
            case let .failure(error):
                promise.reject(with: error)
            }
        }
        return promise
    }
    
    func compactMap<NextValue>(_ closure: @escaping (Value) throws -> NextValue?)-> Future<NextValue> {
        let promise = Promise<NextValue>()
        observe { result in
            switch result {
            case let .success(value):
                do {
                    guard let nextValue = try closure(value) else {
                        return promise.reject(with: FutureMapErrors.missingValue)
                    }
                    promise.resolve(with: nextValue)
                }
                catch {
                    promise.reject(with: error)
                }
            case let .failure(error):
                promise.reject(with: error)
            }
        }
        return promise
    }
    
    func then<NextValue>(_ closure: @escaping (Value) throws -> Future<NextValue>) -> Future<NextValue> {
        let promise = Promise<NextValue>()
        observe { result in
            switch result {
            case .success(let value):
                do {
                    let future = try closure(value)
                    future.observe { result in
                        switch result {
                        case .success(let value):
                            promise.resolve(with: value)
                        case .failure(let error):
                            promise.reject(with: error)
                        }
                    }
                } catch {
                    promise.reject(with: error)
                }
            case .failure(let error):
                promise.reject(with: error)
            }
        }        
        return promise
    }
}
