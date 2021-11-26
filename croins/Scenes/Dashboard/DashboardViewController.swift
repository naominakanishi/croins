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
        
    }
    
    private func setupConstraints() {
        
    }
}
