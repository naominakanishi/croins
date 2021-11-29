import UIKit

final class Category: Comparable {
    let title: String
    // let color: UIColor
    let target: Money
    let color: UIColor
    
    init(title: String, target: Money, color: UIColor) {
        self.title = title
        self.target = target
        self.color = color
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.title == rhs.title && lhs.target == rhs.target && lhs.color == rhs.color
    }
    
    static func < (lhs: Category, rhs: Category) -> Bool {
        lhs.target < rhs.target
    }
}
