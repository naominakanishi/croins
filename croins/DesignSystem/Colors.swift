import UIKit

enum CroinColor {
    static let blue: UIColor = .hex(0x075BF7)
    static let green: UIColor = .hex(0x40D9A2)
    static let pink: UIColor = .hex(0xF784C2)
    static let white: UIColor = .hex(0xFFFFFF)
    static let offwhite: UIColor = .hex(0xF2F2F2)
    static let darkGrey: UIColor = .hex(0x34344C)
    static let black: UIColor = .hex(0x181623)
    
    
}

extension UIColor {
    static var croinColor: CroinColor.Type { CroinColor.self }
}
