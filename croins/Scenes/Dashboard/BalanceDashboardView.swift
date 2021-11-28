import UIKit


class BalanceDashboardView: UIView {
    
    private lazy var balanceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var monthlyRecordsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 7
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var balanceTitle: UILabel = {
        let view = UILabel()
        view.text = "Saldo atual"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = CroinColor.white
        return view
    }()
    
    private lazy var balanceValue: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = CroinColor.white
        return view
    }()
    
    private lazy var monthlyTitle: UILabel = {
        let view = UILabel()
        view.text = "registros do mês"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = CroinColor.white
        return view
    }()
    
    private lazy var separator: UIImageView = {
        let view = UIImageView()
        view.tintColor = CroinColor.green.withAlphaComponent(0.15)
        return view
    }()
    
    private lazy var monthlyInView: InOutView = {
        let view = InOutView()
        return view
    }()
    
    private lazy var monthlyOutView: InOutView = {
        let view = InOutView()
        return view
    }()
    
    init(balance: String, monthlyIn: String, monthlyOut: String) {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        balanceValue.text = balance
        self.layer.cornerRadius = 20
        layer.borderColor = CroinColor.green.withAlphaComponent(0.15).cgColor
        layer.borderWidth = 2
        self.monthlyInView.text = monthlyIn
        self.monthlyOutView.text = monthlyOut
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(balanceStackView)
        self.addSubview(monthlyRecordsStackView)
        self.addSubview(separator)
        balanceStackView.addArrangedSubview(balanceTitle)
        balanceStackView.addArrangedSubview(balanceValue)
        monthlyRecordsStackView.addArrangedSubview(monthlyTitle)
        monthlyRecordsStackView.addArrangedSubview(monthlyInView)
        monthlyRecordsStackView.addArrangedSubview(monthlyOutView)
    }
    
    func constraintSubviews() {
        separator.layout {
            $0.widthAnchor.constraint(equalToConstant: 2)
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        }
        
        balanceStackView.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.Horizontal.s4)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.Horizontal.s4)
            $0.centerYAnchor.constraint(equalTo: monthlyRecordsStackView.centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: separator.leadingAnchor)
        }
        
        monthlyRecordsStackView.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.Horizontal.s4)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(equalTo: separator.trailingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        }
    }
}


final class InOutView: UIView {
    // MARK: - UI Components
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow-up")
        return view
    }()
    

    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.text = "R$ 9,00"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = CroinColor.white
        return view
    }()
    
    // MARK: - Properties
    
    var text: String? {
        didSet {
            valueLabel.text = text
        }
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    func addSubviews() {
        addSubview(iconImageView)
        addSubview(valueLabel)
    }
    
    func constraintSubviews() {
        valueLabel.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        iconImageView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            $0.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8)
            $0.widthAnchor.constraint(equalToConstant: 12)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }
    }
}
