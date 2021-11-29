import UIKit

class BalanceViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    var inputViewModel: InputViewModel!
    
    var balanceView: BalanceView? { view as? BalanceView }
    
    override func loadView() {
        view = BalanceView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        balanceView?.configure(
            bars: inputViewModel.getMonthlyCharts(),
            recentTransactions: inputViewModel.getRecentTransactions(maxLength: 8),
            balance: inputViewModel.getCurrentBalance())
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
