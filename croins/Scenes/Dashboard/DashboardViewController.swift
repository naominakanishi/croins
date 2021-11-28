import UIKit

class DashboardViewController: UIViewController {
    
    //--MARK: declaração das variáveis
    
    private lazy var headerLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "rectangle.fill")
        return view
    }()
    
    private lazy var welcomeMessage: UILabel = {
        let view = UILabel()
        view.text = "Olá, Gonzi"
        view.font = .boldSystemFont(ofSize: 25)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    

    private lazy var balanceView: BalanceDashboardView = {
        let view = BalanceDashboardView(balance: "R$ 432.00", monthlyIn: "R$ 10.00", monthlyOut:"R$ 3.00")
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
    }
    
    private func setupConstraints() {
        headerLogo.layout {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.widthAnchor.constraint(equalToConstant: 80)
            $0.heightAnchor.constraint(equalToConstant: 20)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        }
        
        welcomeMessage.layout {
            $0.topAnchor.constraint(equalTo: headerLogo.bottomAnchor, constant: 10)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
          //  $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
//
        balanceView.layout {
            $0.topAnchor.constraint(equalTo: welcomeMessage.bottomAnchor, constant: 10)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
    }
}
