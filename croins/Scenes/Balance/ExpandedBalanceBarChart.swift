import UIKit

final class ExpandedBalanceBarChart: UITableViewCell {
    
    struct Model {
        let dateRange: String
        let monthIncome: String
        let monthOutcome: String
        let balance: String
        let balanceColor: UIColor?
        let inPercent: Double
        let outPercent: Double
    }
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dateRangeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .callout)
        return view
    }()
    
    private lazy var monthlyIncomeTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Entradas do mês"
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .caption1)
        return view
    }()
    
    private lazy var monthlyIncomeValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .croinColor.green
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var monthlyOutcomeTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Saídas do mês"
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .caption1)
        return view
    }()
    
    private lazy var monthlyOutcomeValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .croinColor.pink
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private lazy var chartView: TransactionBarChartView = {
        let view = TransactionBarChartView()
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(dateRangeLabel)
        containerView.addSubview(monthlyIncomeTitleLabel)
        containerView.addSubview(monthlyIncomeValueLabel)
        containerView.addSubview(monthlyOutcomeTitleLabel)
        containerView.addSubview(monthlyOutcomeValueLabel)
        containerView.addSubview(chartView)
        containerView.addSubview(balanceLabel)
    }
    
    func constraintSubviews() {
        constraintContainerView()
        constraintDateRangeLabel()
        constraintMonthlyIncomeTitleLabel()
        constraintMonthlyIncomeValueLabel()
        constraintMonthlyOutcomeTitleLabel()
        constraintMonthlyOutcomeValueLabel()
        constraintChartView()
        constraintBalanceLabel()
        
    }
    
    func configure(using model: Model) {
        dateRangeLabel.text = model.dateRange
        monthlyIncomeValueLabel.text = model.monthIncome
        monthlyOutcomeValueLabel.text = model.monthOutcome
        balanceLabel.text = model.balance
        balanceLabel.textColor = model.balanceColor
        chartView.configure(using: .init(
            inPercentage: model.inPercent,
            outPercentage: model.outPercent
        ))
    }
}

final class TransactionBarChartView: UIView {
    struct Model {
        let inPercentage: Double
        let outPercentage: Double
    }
    
    private var model: Model?
    
    func configure(using model: Model) {
        self.model = model
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let model = model else { return }
        drawIncomeBar(percentage: model.inPercentage)
        drawOutcomeBar(percentage: model.outPercentage)
    }
    
    private func drawIncomeBar(percentage: Double) {
        let rect = bounds
        let bar = CGRect(
            origin: .init(
                x: rect.minX,
                y: rect.maxY),
            size: .init(
                width: 14,
                height: rect.height * percentage))
        let path = UIBezierPath(
            roundedRect: bar,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: .init(width: 2, height: 2))
        UIColor.croinColor.green.setFill()
        path.fill()
        
    }
    
    private func drawOutcomeBar(percentage: Double) {
        let rect = bounds
        let bar = CGRect(
            origin: .init(
                x: rect.maxX - 14,
                y: rect.maxY),
            size: .init(
                width: 14,
                height: rect.height * percentage))
        let path = UIBezierPath(
            roundedRect: bar,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: .init(width: 2, height: 2))
        UIColor.croinColor.pink.setFill()
        path.fill()
    }
}

private extension ExpandedBalanceBarChart {
    
    func constraintContainerView() {
        containerView.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        }
    }

    func constraintDateRangeLabel() {
        dateRangeLabel.layout {
            $0.topAnchor.constraint(equalTo: containerView.topAnchor)
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        }
    }
    
    func constraintMonthlyIncomeTitleLabel() {
        monthlyIncomeTitleLabel.layout {
            $0.topAnchor.constraint(equalTo: chartView.topAnchor)
            $0.trailingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: -8)
        }
    }
    
    func constraintMonthlyIncomeValueLabel() {
        monthlyIncomeValueLabel.layout {
            $0.topAnchor.constraint(equalTo: monthlyIncomeTitleLabel.bottomAnchor, constant: 16)
            $0.centerXAnchor.constraint(equalTo: monthlyIncomeTitleLabel.centerXAnchor)
        }
    }
    
    func constraintMonthlyOutcomeTitleLabel() {
        monthlyOutcomeTitleLabel.layout {
            $0.bottomAnchor.constraint(equalTo: chartView.centerYAnchor, constant: 8)
            $0.leadingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 16)
        }
    }
    
    func constraintMonthlyOutcomeValueLabel() {
        monthlyOutcomeValueLabel.layout {
            $0.topAnchor.constraint(equalTo: monthlyOutcomeTitleLabel.bottomAnchor, constant: 16)
            $0.leadingAnchor.constraint(equalTo: monthlyIncomeTitleLabel.trailingAnchor)
        }
    }
    
    func constraintChartView() {
        chartView.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            $0.widthAnchor.constraint(equalToConstant: 43)
            $0.topAnchor.constraint(equalTo: dateRangeLabel.bottomAnchor, constant: 32)
            $0.bottomAnchor.constraint(equalTo: balanceLabel.topAnchor, constant: -32)
        }
    }
    
    func constraintBalanceLabel() {
        balanceLabel.layout {
            $0.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        }
    }
    
}
