import UIKit

class TransactionButtons: UIView {
    
    private lazy var buttonLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 13)
        view.numberOfLines = 0
        view.textColor = .white
        view.textAlignment = .center
        
        return view
    }()
    
    private lazy var buttonImage: UIImageView = {
        let view = UIImageView()
        view.layout {
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor)
            $0.heightAnchor.constraint(equalToConstant: 32)
        }
        return view
    }()
    
    init(label: String, image: String) {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        buttonLabel.text = label
        buttonImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(buttonImage)
        self.addSubview(buttonLabel)
    }
    
    func constraintSubviews() {
        buttonImage.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
        
        buttonLabel.layout {
            $0.topAnchor.constraint(equalTo: buttonImage.bottomAnchor, constant: Spacing.Horizontal.s5)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
}
