import UIKit

final class NumberFormattedTextField: TextField, UITextFieldDelegate {
    
    private(set) var amount: Money = 0
    
    override init(inset: CGFloat) {
        super.init(inset: inset)
        addTarget(self,
                  action: #selector(amountDidChange),
                  for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func amountDidChange() {
        guard let text = text
        else {
            text = "R$ 0,00"
            return
        }
        let digits = text
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        guard let number = Int(digits) else {
            self.text = "R$ 0,00"
            return
        }
        let money = Money(number) / 100
        self.amount = money
        self.text = NumberFormatter.currencyFormatter().string(from: money)
    }
}
