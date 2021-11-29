import UIKit

class BalanceViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    var inputViewModel: InputViewModel!
    
    var balanceView: BalanceView? { view as? BalanceView }
    
    override func loadView() {
        view = BalanceView(viewModel: inputViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        balanceView?.configure(bars: [
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
            .init(
                inPercentage: .random(in: 0...1),
                outPercentage: .random(in: 0...1),
                dateRange: "01/FEB-26/FEB",
                balance: "+R$320,00",
                balanceColor: .systemOrange,
                isSelected: false
            ),
        ],
        recentTransactions: [
            .init(
                isPositive: true,
                name: "asdad",
                category: "ewqewq",
                amount: 300),
            .init(
                isPositive: true,
                name: "asdad",
                category: "ewqewq",
                amount: 300),
            .init(
                isPositive: true,
                name: "asdad",
                category: "ewqewq",
                amount: 300),
            .init(
                isPositive: true,
                name: "asdad",
                category: "ewqewq",
                amount: 300),
            .init(
                isPositive: true,
                name: "asdad",
                category: "ewqewq",
                amount: 300),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        balanceView?.viewDidAppear()
        navigationController?.presentationController?.delegate = self
    }
    
    
    func configureNavigationBar() {
        title = "Extrato"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
