import UIKit

class BarCollectionViewCell: UICollectionViewCell {
    
    struct Bar {
        let inPercentage: Double
        let outPercentage: Double
        let dateRange: String
        let balance: String
        let balanceColor: UIColor?
        let isSelected: Bool
        let date: Date
    }
    
    private lazy var pinkBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .croinColor.pink
        view.layer.cornerRadius = 2
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return view
    }()
    
    private lazy var greenBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .croinColor.green
        view.layer.cornerRadius = 2
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return view
    }()
    
    private lazy var baseLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex(0x7F8192)
        return view
    }()
    
    private lazy var dateMarker: UIView = {
        let view = UIView()
        view.backgroundColor = .hex(0x7F8192)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .caption2)
        view.textColor = .hex(0x7F8192)
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var greenBarHeight: NSLayoutConstraint?
    private var pinkBarHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(pinkBarView)
        containerView.addSubview(greenBarView)
        containerView.addSubview(dateMarker)
        containerView.addSubview(dateLabel)
        containerView.addSubview(balanceLabel)
        containerView.addSubview(baseLineView)
    }
    
    private func setupConstraints() {
        constraintContainerView()
        constraintPinkBarView()
        constraintGreenBarView()
        constraintDateMarker()
        constraintDateLabel()
        constraintBalanceLabel()
        constraintBaseLineView()
    }
    
    func configure(using bar: Bar) {
        dateLabel.text = bar.dateRange
        balanceLabel.text = bar.balance
        balanceLabel.textColor = bar.balanceColor
        
        greenBarHeight?.constant = bar.inPercentage * frame.height
        pinkBarHeight?.constant = bar.outPercentage * frame.height
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

private extension BarCollectionViewCell {
    func constraintContainerView() {
        containerView.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        }
    }
    
    func constraintPinkBarView() {
        let heightAnchor = pinkBarView.heightAnchor.constraint(equalToConstant: 0)
        pinkBarView.layout {
            $0.leadingAnchor.constraint(equalTo: dateMarker.trailingAnchor, constant: 8)
            $0.bottomAnchor.constraint(equalTo: baseLineView.topAnchor)
            $0.widthAnchor.constraint(equalToConstant: 14)
            heightAnchor
        }
        pinkBarHeight = heightAnchor
    }
    
    func constraintGreenBarView() {
        let heightAnchor = greenBarView.heightAnchor.constraint(equalToConstant: 0)
        greenBarView.layout {
            $0.trailingAnchor.constraint(equalTo: dateMarker.leadingAnchor, constant: -8)
            $0.bottomAnchor.constraint(equalTo: baseLineView.topAnchor)
            $0.widthAnchor.constraint(equalToConstant: 14)
            heightAnchor
        }
        
        greenBarHeight = heightAnchor
    }
    
    func constraintBaseLineView() {
        baseLineView.layout {
            $0.bottomAnchor.constraint(equalTo: dateMarker.topAnchor)
            $0.heightAnchor.constraint(equalToConstant: 1)
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        }
    }
    
    func constraintDateMarker() {
        dateMarker.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4)
            $0.widthAnchor.constraint(equalToConstant: 1)
            $0.heightAnchor.constraint(equalToConstant: 10)
        }
    }
    
    func constraintDateLabel() {
        
        dateLabel.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: balanceLabel.topAnchor, constant: -2)
        }
    }
    
    func constraintBalanceLabel() {
        balanceLabel.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        }
    }
}


