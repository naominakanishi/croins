import UIKit

class BarCollectionViewCell: UICollectionViewCell {
    
    private lazy var pinkBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var greenBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var baseLineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dateMarker: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var greenBarHeight: NSLa?
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
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
        
    }
    func constraintGreenBarView() {
        let heightAnchor = greenBarView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        greenBarView.layout {
            $0.trailingAnchor.constraint(equalTo: dateMarker.leadingAnchor, constant: -8)
            $0.bottomAnchor.constraint(equalTo: baseLineView.topAnchor)
            $0.widthAnchor.constraint(equalToConstant: 14)
            heightAnchor
        }
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
            $0.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -8)
            $0.widthAnchor.constraint(equalToConstant: 1)
            $0.heightAnchor.constraint(equalToConstant: 10)
        }
    }
    
    func constraintDateLabel() {
        
        dateLabel.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: -8)
        }
    }
    
    func constraintBalanceLabel() {
        balanceLabel.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        }
    }
}
