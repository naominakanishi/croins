import UIKit

final class Category {
    let title: String
    // let color: UIColor
    let target: Money
    let color: UIColor
    
    init(title: String, target: Money, color: UIColor) {
        self.title = title
        self.target = target
        self.color = color
    }
}
