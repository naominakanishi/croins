import UIKit
import Intents

class NewInputViewController: UIViewController {
    
    let inputViewModel = InputViewModel()
    
    let pageTitle: UILabel = {
        let pageTitle = UILabel()
        pageTitle.text = "Vamos lá"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 32)
        pageTitle.numberOfLines = 0
        return pageTitle
    }()
    
    let pageContent: UILabel = {
        let pageContent = UILabel()
        pageContent.text = "Você recebeu ou gastou esse dinheiro?"
        pageContent.font = UIFont.systemFont(ofSize: 18)
        pageContent.numberOfLines = 0
        return pageContent
    }()
    
    let spentMoneyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleSpentMoneyButtonTap(_:)), for: .touchUpInside)
        button.setTitle("Perdoa, gastei a grana", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let receivedMoneyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleReceiveMoneyButtonTap(_:)), for: .touchUpInside)
        button.setTitle("Amém, caiu a bolsa", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
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
        view.backgroundColor = .white
    }

    
    func addSubviews() {
        view.addSubview(pageTitle)
        view.addSubview(pageContent)
        view.addSubview(spentMoneyButton)
        view.addSubview(receivedMoneyButton)
    }
    
    func setupConstraints() {
        //MARK: page title constraints
        pageTitle.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        //MARK: page content constraints:
        pageContent.layout {
            $0.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        //MARK: received money button constraints:
        receivedMoneyButton.layout {
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.titleLabel?.centerXAnchor.constraint(equalTo: $0.centerXAnchor)
            $0.titleLabel?.centerYAnchor.constraint(equalTo: $0.centerYAnchor)
        }
        
        
        //MARK: spent money button constraints:
        spentMoneyButton.layout {
            $0.bottomAnchor.constraint(equalTo: receivedMoneyButton.topAnchor, constant: -20)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.titleLabel?.centerXAnchor.constraint(equalTo: $0.centerXAnchor)
            $0.titleLabel?.centerYAnchor.constraint(equalTo: $0.centerYAnchor)
        }
    }
}

@objc
private extension NewInputViewController {
    func handleSpentMoneyButtonTap(_ sender: Any) {
        /*let startController = NewEntryViewController()
        navigationController?.pushViewController(startController, animated: true)*/
        let successfulViewController = SuccessfulRegisterViewController()
        successfulViewController.inputViewModel.setNewInputModel(InputModel(title: "Gasto Registrado", image: UIImage(systemName: "photo.fill")!, siriIntent: CreateExpenseIntent()))
        successfulViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(successfulViewController, animated: true, completion: nil)
    }
    
    func handleReceiveMoneyButtonTap(_ sender: Any) {
        /*let startController = NewEntryViewController()
        navigationController?.pushViewController(startController, animated: true)*/
        let successfulViewController = SuccessfulRegisterViewController()
        successfulViewController.inputViewModel.setNewInputModel(InputModel(title: "Entrada Registrada", image: UIImage(systemName: "photo.fill")!, siriIntent: CreateIncomeIntent()))
        successfulViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(successfulViewController, animated: true, completion: nil)
    }
}
