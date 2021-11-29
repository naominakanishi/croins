import UIKit
import Intents
import IntentsUI

class DashboardViewController: UIViewController, DashboardTransactionRecordDelegate {
    
    var inputViewModel = InputViewModel()
    var categoryViewModel = CategoryViewModel()
    
    func didTapOnEntryButton() {
        let controller = NewEntryViewController()
        controller.configuration = .init(
            style: .income,
            onTap: { _, _, _, _ in }
        )
        controller.inputViewModel = inputViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapOnSpentButton() {
        let controller = NewEntryViewController()
        controller.configuration = .init(
            style: .outcome,
            onTap: { _, _, _, _ in }
        )
        controller.inputViewModel = inputViewModel
        controller.categoryViewModel = categoryViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapOnCamera() {
        let controller = VisionViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapOnVoiceCommand() {
        setupIntentsAlertController()
    }
    
    
    //--MARK: declaração das variáveis
    
    private lazy var headerLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "croins-logo")
        return view
    }()
    
    private lazy var welcomeMessage: UILabel = {
        let view = UILabel()
        view.text = "Olá, Gonzi"
        view.font = .boldSystemFont(ofSize: 34)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    

    private lazy var balanceView: BalanceDashboardView = {
        let view = BalanceDashboardView(balance: "R$ 432.00", monthlyIn: "R$ 10.00", monthlyOut:"R$ 3.00")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBalanceTap)))
        return view
    }()
    
    private lazy var transactionRecordView: DashboardTransactionRecordView = {
        let view = DashboardTransactionRecordView()
        view.delegate = self
        return view
    }()
    
    private lazy var categoriesView: DashboardCategoriesView = {
        let view = DashboardCategoriesView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCategoryTap)))
        
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .croinColor.black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        addSubviews()
        setupConstraints()
        AppDatabase.shared.subscribe(self)
    }
    
    private func addSubviews() {
        view.addSubview(headerLogo)
        view.addSubview(welcomeMessage)
        view.addSubview(balanceView)
        view.addSubview(transactionRecordView)
        view.addSubview(categoriesView)
    }
    
    private func setupConstraints() {
        headerLogo.layout {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.Horizontal.s3)
            $0.widthAnchor.constraint(equalToConstant: 100)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.Vertical.s2)

        }
        
        welcomeMessage.layout {
            $0.topAnchor.constraint(
                equalTo: headerLogo.bottomAnchor,
                constant: Spacing.Horizontal.s1 + Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.Vertical.s2)
        }

        balanceView.layout {
            $0.topAnchor.constraint(equalTo: welcomeMessage.bottomAnchor, constant: Spacing.Horizontal.s1)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.Vertical.s4)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.Vertical.s4)
        }
        
        transactionRecordView.layout {
            $0.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: Spacing.Vertical.s3)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.Vertical.s2)
        }
        
        categoriesView.layout {
            $0.topAnchor.constraint(equalTo: transactionRecordView.bottomAnchor, constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.Vertical.s4)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.Vertical.s4)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        categoriesView.configure(using: [
            .init(
                categoryName: "asdasd",
                progress: .init(
                    total: 10,
                    progress: 4)),
            .init(
                categoryName: "asdasd",
                progress: .init(
                    total: 10,
                    progress: 4)),
            .init(
                categoryName: "asdasd",
                progress: .init(
                    total: 10,
                    progress: 4)),
        ])
    }
    
    @objc func handleBalanceTap () {
        let controller = BalanceViewController()
        controller.inputViewModel = inputViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleCategoryTap () {
        let controller = CategoriesViewController()
        controller.categoryViewModel = categoryViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupIntentsAlertController() {
        let incomeAction = UIAlertAction(title: "Nova Entrada", style: .default) { _ in
            if let shortcut = INShortcut(intent: CreateIncomeIntent()) {
                let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                viewController.modalPresentationStyle = .formSheet
                viewController.delegate = self
                self.present(viewController, animated: true, completion: nil)
            }
        }
        
        let outcomeAction = UIAlertAction(title: "Nova Saída", style: .default) { _ in
            if let shortcut = INShortcut(intent: CreateExpenseIntent()) {
                let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                viewController.modalPresentationStyle = .formSheet
                viewController.delegate = self
                self.present(viewController, animated: true, completion: nil)
            }
        }
        
        let alert = UIAlertController(title: "Criar novo atalho", message: "Selecione o tipo de atalho que deseja cadastrar", preferredStyle: .actionSheet)
        alert.addAction(incomeAction)
        alert.addAction(outcomeAction)
        self.present(alert, animated: true)
    }
}

extension DashboardViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DashboardViewController: DatabaseSubscriber {
    func onDatabaseChange() {
        let database = AppDatabase.shared
        categoriesView.configure(using: database.categories!.map{
            .init(
                categoryName: $0.title,
                progress: .init(
                    total: $0.target,
                    progress: database.progress(for: $0)
                ))
        })
    }
}
