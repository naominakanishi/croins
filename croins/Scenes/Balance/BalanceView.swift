import UIKit

class BalanceView: UIView {
    
    var inputViewModel: InputViewModel!
    
    private let recentTransactionsView = RecentTransactionsView()
    private let chartView = BalanceChartView()
    private lazy var currentBalanceTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .title3)
        view.text = "Saldo atual"
        return view
    }()
    
    private lazy var currentBalanceValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .title1)
        view.text = inputViewModel.getCurrentBalance()
        return view
    }()
    
    init(viewModel: InputViewModel) {
        inputViewModel = viewModel
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        backgroundColor = .hex(0x181623)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(chartView)
        addSubview(currentBalanceTitle)
        addSubview(currentBalanceValueLabel)
        addSubview(recentTransactionsView)
    }
    
    func constraintSubviews() {
        chartView.layout {
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.heightAnchor.constraint(equalToConstant: 200)
        }
        
        currentBalanceTitle.layout {
            $0.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor)
            $0.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16)
        }
        
        currentBalanceValueLabel.layout {
            $0.topAnchor.constraint(
                equalTo: currentBalanceTitle.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: currentBalanceTitle.leadingAnchor)
        }
        
        recentTransactionsView.layout {
            $0.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -24)
            $0.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8)
            $0.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8)
        }
    }
    
    func configure(
        bars: [BalanceChartView.Bar],
        recentTransactions: [TransactionRecordView.Model]
    ) {
        chartView.configure(using: bars)
        recentTransactionsView.configure(using: recentTransactions)
    }
    
    func viewDidAppear() {
        chartView.scrollToEnd()
    }
}
