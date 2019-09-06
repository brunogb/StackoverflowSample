//
//  StackOverflowUser.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

struct StackOverflowUser: Decodable {

    let id: Int
    let name: String
    let imageURL: String
    let reputation: Int
    
    init(from decoder: Decoder) throws {
        self.id = try decoder.decode("account_id")
        self.name = try decoder.decode("display_name")
        self.imageURL = try decoder.decode("profile_image")
        self.reputation = try decoder.decode("reputation")
    }
    
}
