import UIKit

final class RecentTransactionsView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "transações recentes"
        view.font = .preferredFont(forTextStyle: .body)
        view.textColor = .white
        return view
    }()
    
    private lazy var transactionsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private lazy var seeAllButton: UIButton = {
        let view = UIButton()
        view.setTitle("ver todas", for: .normal)
        view.setImage(.init(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.setTitleColor(.hex(0xA5A6F6), for: .normal)
        view.imageView?.tintColor = .hex(0xA5A6F6)
        view.semanticContentAttribute = .forceRightToLeft
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageEdgeInsets = .init(top: 5, left: 0, bottom: 4, right: 0)
        view.addTarget(self, action: #selector(handleSeeAllTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        constraintSubviews()
        layer.borderColor = UIColor.hex(0x212131).withAlphaComponent(0.5).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(transactionsStackView)
        addSubview(seeAllButton)
    }
    
    func constraintSubviews() {
        titleLabel.layout {
            $0.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16)
            $0.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16)
        }
        
        transactionsStackView.layout {
            $0.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 24)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            $0.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -20)
        }
        
        seeAllButton.layout {
            $0.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
            $0.trailingAnchor.constraint(
                equalTo: transactionsStackView.trailingAnchor)
        }
    }
    
    func configure(using records: [TransactionRecordView.Model]) {
        transactionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        records.forEach {
            let view = TransactionRecordView()
            view.configure(using: $0)
            transactionsStackView.addArrangedSubview(view)
        }
        setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func handleSeeAllTapped() {
        
    }
}
