import UIKit

class BalanceView: UIView {
    
    private let chartView = BalanceChartView()
    
    init() {
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
    }
    
    func constraintSubviews() {
        chartView.layout {
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.heightAnchor.constraint(equalToConstant: 200)
        }
    }
    
    func configureChart(using bars: [BalanceChartView.Bar]) {
        chartView.configure(using: bars)
    }
    
    func viewDidAppear() {
        chartView.scrollToEnd()
    }
}
