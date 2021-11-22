import UIKit

final class Category {
    let title: String
    // let color: UIColor
    let target: Money
    
    init(title: String, target: Money) {
        self.title = title
        self.target = target
    }
}
