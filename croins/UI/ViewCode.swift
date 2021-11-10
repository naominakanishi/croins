//
//  ViewCode.swift
//  croins
//
//  Created by Naomi Nakanishi on 10/11/21.
//

import UIKit

@resultBuilder
struct ConstraintBuilder {
    static func buildBlock(_ components: NSLayoutConstraint?...) -> [NSLayoutConstraint?] {
        components
    }
}

protocol LayoutMaker {}

extension LayoutMaker where Self: UIView {
    func layout(
        @ConstraintBuilder using constraints: (Self) -> [NSLayoutConstraint?]
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints(self).compactMap { $0 })
    }
    
}

extension UIView: LayoutMaker {}
