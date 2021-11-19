import UIKit

class SuccessfulRegisterViewController: UIViewController {
    
    let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let pageTitle: UILabel = {
        let view = UILabel()
        view.textColor = .green
        view.text = "Teste"
        return view
    }()
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        backgroundView.layout {
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        }
    }
    
}
