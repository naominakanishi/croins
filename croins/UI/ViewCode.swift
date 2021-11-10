//
//  ViewCode.swift
//  croins
//
//  Created by Naomi Nakanishi on 10/11/21.
//

import UIKit

@resultBuilder
struct ConstraintBuilder {
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        components
    }
}

extension UIView {
    func layout(@ConstraintBuilder using constraints: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints(self))
    }
}
