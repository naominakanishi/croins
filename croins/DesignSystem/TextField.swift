import UIKit

class TextField: UITextField {
    let inset: CGFloat
    
    init(inset: CGFloat) {
        self.inset = inset
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // placeholder position
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: self.inset)
    }

    // text position
    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset , dy: self.inset)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.inset, dy: self.inset)
    }
}
