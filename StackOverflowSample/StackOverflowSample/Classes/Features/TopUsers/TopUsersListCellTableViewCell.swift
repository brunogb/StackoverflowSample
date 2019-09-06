//
//  TopUsersListCellTableViewCell.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

class TopUsersListCellTableViewCell: UITableViewCell {

    var currentPromise: Future<UIImage?> = Promise(value: .none)
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fixedSize(size: CGSize(width: 80, height: 80))
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var reputationLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var actionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        return view
    }()
    
    lazy var actionContainerHeightConstraint: NSLayoutConstraint = self.actionContainer.heightAnchor.constraint(equalToConstant: 54)
    
    lazy var followButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Follow", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    lazy var blockButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Block", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupCell() {
        self.contentView.addSubview(self.profileImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.reputationLabel)
        self.contentView.addSubview(self.actionContainer)
        
        self.actionContainer.addSubview(self.followButton)
        self.actionContainer.addSubview(self.blockButton)
        
        NSLayoutConstraint.activate([
            self.profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 8),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor, constant: 4),
            self.reputationLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.reputationLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.reputationLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4),
            self.actionContainer.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 8),
            self.actionContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.actionContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.actionContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            self.actionContainerHeightConstraint,
            self.followButton.leadingAnchor.constraint(equalTo: self.actionContainer.leadingAnchor, constant: 16),
            self.blockButton.trailingAnchor.constraint(equalTo: self.actionContainer.trailingAnchor, constant: -16),
            self.followButton.centerYAnchor.constraint(equalTo: self.actionContainer.centerYAnchor),
            self.blockButton.centerYAnchor.constraint(equalTo: self.actionContainer.centerYAnchor),
            self.followButton.widthAnchor.constraint(equalTo: self.blockButton.widthAnchor, multiplier: 1),
            self.followButton.trailingAnchor.constraint(equalTo: self.blockButton.leadingAnchor, constant: 16)
        ])
    }
    
    override func prepareForReuse() {
        self.currentPromise = Promise(value: .none)
        self.profileImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.actionContainerHeightConstraint.constant = selected ? 54 : 54
        self.setNeedsLayout()
    }
    
    func configure(with viewModel: TopUsersListCellViewModel, apiClient: StackOverflowAPI) {
        self.nameLabel.text = viewModel.userName
        self.reputationLabel.text = "Reputation: \(viewModel.reputation)"
        self.currentPromise = viewModel.avatarImage(from: apiClient)
        self.currentPromise.observe(with: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.profileImageView.image = nil
                case let .success(image):
                    self.profileImageView.image = image
                }
                self.setNeedsLayout()
            }
        })
        self.setNeedsLayout()
    }

}
