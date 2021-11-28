import UIKit

class BalanceViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    var balanceView: BalanceView? { view as? BalanceView }
    
    override func loadView() {
        view = BalanceView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        balanceView?.configureChart(using: [
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
