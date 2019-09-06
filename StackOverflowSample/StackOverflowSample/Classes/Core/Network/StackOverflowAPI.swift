//
//  StackOverflowAPI.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

protocol StackOverflowAPI {

    func fetchTopUsers()-> Future<[StackOverflowUser]>
    func fetchAvatar(from url: URL)-> Future<UIImage?>
    
    
}
