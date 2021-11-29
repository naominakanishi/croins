import Foundation

/// This represents the value in cents. Floating point can go nuts here
typealias Money = Double

extension Money {
    
    /// Returns formatted value. Ex.: 10,32 becomes R$ 10,32
    var currency: String? {
        NumberFormatter.currencyFormatter().string(from: self as NSNumber)
    }
}

extension NumberFormatter {
    static func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        return formatter
    }
}


extension NumberFormatter {
    func string(from money: Money) -> String? {
        string(from: money as NSNumber)
    }
}
