//
//  TopUsersListCellViewModel.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

struct TopUsersListCellViewModel {

    let cellIdentifier = "userCell"
    
    let userProfileImage: String
    let userName: String
    let reputation: Int
    
    func avatarImage(from apiClient: StackOverflowAPI)-> Future<UIImage?> {
        guard let avatarURL = URL(string: userProfileImage) else {
            return Promise(value: nil)
        }
        return apiClient.fetchAvatar(from: avatarURL)
    }
    
}
