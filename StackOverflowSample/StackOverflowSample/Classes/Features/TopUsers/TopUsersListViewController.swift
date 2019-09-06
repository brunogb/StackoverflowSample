//
//  TopUsersListViewController.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

class TopUsersListViewController: UIViewController {

    let viewModel: TopUsersListViewModel
    let apiClient: StackOverflowAPI
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    init(apiClient: StackOverflowAPI) {
        self.apiClient = apiClient
        self.viewModel = TopUsersListViewModel(apiClient: apiClient)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alignInsideSuperview()
        self.viewModel.onViewLoaded()
        self.viewModel.onModelChange = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
}

extension TopUsersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopUsersListCellTableViewCell = tableView.dequeue(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TopUsersListCellTableViewCell else { return }
        let cellViewModel = self.viewModel.cellViewModel(for: indexPath)
        cell.configure(with: cellViewModel, apiClient: self.apiClient)
    }
    
}
