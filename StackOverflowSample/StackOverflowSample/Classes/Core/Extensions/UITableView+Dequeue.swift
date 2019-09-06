//
//  UITableView+Dequeue.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

extension UITableView {

    private static var registeredIdentifiers: UInt8 = 0
    
    private var registeredIdentifiers: [String] {
        get {
            return (objc_getAssociatedObject(self, &UITableView.registeredIdentifiers) as? [String]) ?? []
        }
        set {
            objc_setAssociatedObject(self, &UITableView.registeredIdentifiers, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func dequeue<Cell: UITableViewCell>(identifier: String = String(describing: type(of: Cell.self)), indexPath: IndexPath)-> Cell {
        if !registeredIdentifiers.contains(identifier) {
            self.register(Cell.self, forCellReuseIdentifier: identifier)
            self.registeredIdentifiers.append(identifier)
        }
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let transformedCell = cell as? Cell else {
            fatalError("cell registered with wrong class. Expected: \(String(describing: Cell.self)), got: \(type(of: cell))")
        }
        return transformedCell
    }
    
}
