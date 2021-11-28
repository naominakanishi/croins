import UIKit
//import XCTest

class DashboardViewController: UIViewController {
    
    //--MARK: declaração das variáveis
    
    private lazy var headerLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "croins-logo")
        return view
    }()
    
    private lazy var welcomeMessage: UILabel = {
        let view = UILabel()
        view.text = "Olá, Gonzi"
        view.font = .boldSystemFont(ofSize: 25)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    

    private lazy var balanceView: BalanceDashboardView = {
        let view = BalanceDashboardView(balance: "R$ 432.00", monthlyIn: "R$ 10.00", monthlyOut:"R$ 3.00")
        return view
    }()
    
    private lazy var transactionRecordView: DashboardTransactionRecordView = {
        let view = DashboardTransactionRecordView()
        return view
    }()
    
    private lazy var categoriesView: DashboardCategoriesView = {
        let view = DashboardCategoriesView()
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
//            $0.heightAnchor.constraint(equalToConstant: 20)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.Vertical.s2)
//            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        }
        
        welcomeMessage.layout {
            $0.topAnchor.constraint(
                equalTo: headerLogo.bottomAnchor,
                constant: Spacing.Horizontal.s1 + Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.Vertical.s2)
          //  $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
//
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
}
