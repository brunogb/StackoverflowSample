//
//  TopListViewModel.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

class TopUsersListViewModel {

    var userList: [StackOverflowUser] = [] {
        didSet {
            DispatchQueue.main.async {
                self.onModelChange(self)
            }
        }
    }
    
    private let apiClient: StackOverflowAPI
    
    private var currentFuture: Future<[StackOverflowUser]>?
    
    var onModelChange: (TopUsersListViewModel) -> Void = { _ in }
    
    init(apiClient: StackOverflowAPI) {
        self.apiClient = apiClient
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TopUsersListCellViewModel {
        let user = userList[indexPath.row]
        return TopUsersListCellViewModel(userProfileImage: user.imageURL, userName: user.name, reputation: user.reputation)
    }
    
    func onViewLoaded() {
        guard currentFuture == nil else { return }
        currentFuture = apiClient.fetchTopUsers()
        currentFuture?.observe(with: { [weak self] (result) in
            switch result {
            case let .success(userList):
                self?.userList = userList
            case let .failure(error):
                print("\(error.localizedDescription)")
                break;
            }
            self?.currentFuture = nil
        })
    }
    
}
