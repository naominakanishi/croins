import Foundation

/// This represents the value in cents. Floating point can go nuts here
typealias Money = Decimal

extension Money {
    
    /// Returns formatted value. Ex.: 10,32 becomes R$ 10,32
    var currency: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
