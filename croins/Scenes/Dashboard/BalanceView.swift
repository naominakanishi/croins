import UIKit

class BalanceView: UIView {
    
    private lazy var balanceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var monthlyRecordsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var balanceTitle: UILabel = {
        let view = UILabel()
        view.text = "Saldo atual"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var balanceValue: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var monthlyTitle: UILabel = {
        let view = UILabel()
        view.text = "registros do mês"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    
    private lazy var monthlyInIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        return view
    }()
    
    private lazy var monthlyOutIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        return view
    }()

    
    private lazy var monthlyIn: UILabel = {
        let view = UILabel()
        view.text = "R$ 9,00"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var monthlyOut: UILabel = {
        let view = UILabel()
        view.text = "R$ 2,00"
        view.font = .boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var separator: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    init(balance: String, monthlyIn: String, monthlyOut: String) {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        constraintsBalanceStackView()
        constraintsMonthlyRecordsStackView()
        balanceValue.text = balance
        self.layer.cornerRadius = 20
        self.monthlyIn.text = monthlyIn
        self.monthlyOut.text = monthlyOut
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceTitle)
        balanceStackView.addArrangedSubview(balanceValue)
        monthlyRecordsStackView.addArrangedSubview(monthlyRecordsStackView)
        monthlyRecordsStackView.addArrangedSubview(monthlyTitle)
        monthlyRecordsStackView.addArrangedSubview(monthlyInIcon)
        monthlyRecordsStackView.addArrangedSubview(monthlyOutIcon)
        monthlyRecordsStackView.addArrangedSubview(monthlyIn)
        monthlyRecordsStackView.addArrangedSubview(monthlyOut)
    }
    
    func constraintSubviews() {
        separator.layout {
            $0.widthAnchor.constraint(equalToConstant: 2)
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
            $0.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        }
        
        balanceStackView.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: separator.leadingAnchor)
        }
        
        monthlyRecordsStackView.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: separator.trailingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        }
    }
    
    func constraintsBalanceStackView() {
        balanceTitle.layout {
            $0.bottomAnchor.constraint(equalTo: balanceStackView.centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: balanceStackView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: balanceStackView.trailingAnchor)
        }
        balanceValue.layout {
            $0.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: balanceStackView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: balanceStackView.trailingAnchor)
        }
    }
    
    func constraintsMonthlyRecordsStackView() {
        
        monthlyInIcon.layout {
            $0.centerYAnchor.constraint(equalTo: monthlyRecordsStackView.centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: monthlyRecordsStackView.leadingAnchor)
        }
        
        monthlyIn.layout {
            $0.centerYAnchor.constraint(equalTo: monthlyRecordsStackView.centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: monthlyInIcon.trailingAnchor, constant: 10)
            $0.trailingAnchor.constraint(equalTo: monthlyRecordsStackView.trailingAnchor)
        }
        
        monthlyOutIcon.layout{
            $0.topAnchor.constraint(equalTo: monthlyIn.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: monthlyRecordsStackView.leadingAnchor)
        }
        monthlyOut.layout {
            $0.topAnchor.constraint(equalTo: monthlyIn.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: monthlyInIcon.trailingAnchor, constant: 10)
            $0.trailingAnchor.constraint(equalTo: monthlyRecordsStackView.trailingAnchor)
        }
        
        monthlyTitle.layout {
            $0.bottomAnchor.constraint(equalTo: monthlyIn.topAnchor, constant: -10)
            $0.leadingAnchor.constraint(equalTo: monthlyRecordsStackView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: monthlyRecordsStackView.trailingAnchor)
        }
    }
}
