//
//  UIView+Constraints.swift
//  StackOverflowSample
//
//  Created by apple on 04/09/2019.
//  Copyright © 2019 bgondim. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func alignInsideSuperview(insets: UIEdgeInsets = .zero)-> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        let constraints: [NSLayoutConstraint] = [
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right * -1),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom * -1)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
 
    @discardableResult
    func fixedSize(size: CGSize)-> [NSLayoutConstraint] {
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
}
