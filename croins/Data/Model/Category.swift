import UIKit

public final class Category: Comparable, Codable {
    public let title: String
    public let target: Money
    public let color: UIColor
    
    enum CodingKeys: String, CodingKey {
        case title, target, color
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.target = try container.decode(Money.self, forKey: .target)
        let hexString = try container.decode(String.self, forKey: .color)
        let hex = Int(hexString.replacingOccurrences(of: "#", with: ""), radix: 16)!
        self.color = .hex(hex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(target, forKey: .target)
        try container.encode(color.hexString, forKey: .color)
    }
    
    public init(title: String, target: Money, color: UIColor) {
        self.title = title
        self.target = target
        self.color = color
    }
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.title == rhs.title && lhs.target == rhs.target && lhs.color == rhs.color
    }
    
    public static func < (lhs: Category, rhs: Category) -> Bool {
        lhs.target < rhs.target
    }
}

extension UIColor {
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let multiplier = CGFloat(255.999999)

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
