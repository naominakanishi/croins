import UIKit
import CoreCroins

final class TransactionRecordView: UIView {
    
    struct Model {
        let isPositive: Bool
        let name: String
        let category: String?
        let amount: Money
        let date: Date
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .hex(0xE3E3E5)
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        view.textColor = .hex(0xE3E3E5).withAlphaComponent(0.6)
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .callout)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(amountLabel)
    }
    
    func constraintSubviews() {
        imageView.layout {
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.widthAnchor.constraint(equalToConstant: 15)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
        
        nameLabel.layout {
            $0.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: 12)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            $0.trailingAnchor.constraint(equalTo: categoryLabel.leadingAnchor)
            $0.widthAnchor.constraint(equalTo: categoryLabel.widthAnchor)
        }
        
        categoryLabel.layout {
            $0.trailingAnchor.constraint(
                equalTo: amountLabel.leadingAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            $0.widthAnchor.constraint(equalTo: nameLabel.widthAnchor)
        }
        
        amountLabel.layout {
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
    
    func configure(using model: Model) {
        imageView.image = model.isPositive ? .add : .remove
        nameLabel.text = model.name
        categoryLabel.text = model.category
        amountLabel.text = model.amount.formatted()
        amountLabel.textColor = model.isPositive ?
            .croinColor.green :
            .croinColor.pink
    }
}
