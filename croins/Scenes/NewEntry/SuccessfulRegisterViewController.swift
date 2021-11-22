import UIKit

final class SuccessfulRegisterViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // Substituir pelo componente
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private lazy var titleImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.sizeToFit()
        return view
    }()
    
    private lazy var pageTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.text = "Gasto Registrado"
        return view
    }()
    
    private lazy var confirmationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.sizeToFit()
        return view
    }()
    
    private lazy var confirmationLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.text = "Você sabia que pode registrar transações por voz?? EXPERIMENTE ATALHOS DA SIRI!"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(handleConfirmButtonTap(_:)), for: .touchUpInside)
        view.setTitle("EBA", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.titleLabel?.textAlignment = .center
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private lazy var addSiriShortcutButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(handleSiriButtonTap(_:)), for: .touchUpInside)
        view.setTitle("Configurar Siri", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.titleLabel?.textAlignment = .center
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
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
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleImageView)
        titleStackView.addArrangedSubview(pageTitleLabel)
        view.addSubview(confirmationImageView)
        view.addSubview(confirmationLabel)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(confirmButton)
        buttonsStackView.addArrangedSubview(addSiriShortcutButton)
    }
    
    func setupConstraints() {
        backgroundView.layout {
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        }
        
        // Substituir pelo componente
        titleStackView.layout {
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20)
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20)
            $0.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.1)
        }
        
        titleImageView.layout {
            $0.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 0.1)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1)
        }
        
        pageTitleLabel.layout {
            $0.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 0.85)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1)
        }
        
        confirmationImageView.layout {
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20)
            $0.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5)
        }
        
        confirmationLabel.layout {
            $0.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: titleStackView.widthAnchor)
            $0.topAnchor.constraint(equalTo: confirmationImageView.bottomAnchor, constant: 20)
        }
        
        buttonsStackView.layout {
            $0.widthAnchor.constraint(equalTo: titleStackView.widthAnchor)
            $0.centerXAnchor.constraint(equalTo: titleStackView.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20)
            $0.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20)
        }
    }
}

@objc
extension SuccessfulRegisterViewController {
    func handleConfirmButtonTap(_ sender: Any) {
        print("EBA")
    }
    
    func handleSiriButtonTap(_ sender: Any) {
        print("Siri")
    }
}
