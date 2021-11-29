import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var logoView: UIImageView = {
       let logo = UIImageView()
        logo.image = UIImage(named: "croins-logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var pageTitle: UILabel = {
        let pageTitle = UILabel()
        pageTitle.numberOfLines = 0
        pageTitle.font = .systemFont(ofSize: 36)
        pageTitle.textAlignment = .left
        pageTitle.textColor = CroinColor.white
        pageTitle.text = "Seu apelido?"
        return pageTitle
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private lazy var textFieldBackground: UIView = {
       let textFieldBackground = UIView()
        textFieldBackground.backgroundColor = CroinColor.white.withAlphaComponent(4)
        textFieldBackground.layer.cornerRadius = 8
        return textFieldBackground
    }()
    
    private lazy var nameTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .hex(0xF5F6F8)
        view.attributedPlaceholder = .init(
            string: "Seu apelido",
            attributes: [
                .font : UIFont.systemFont(ofSize: 14),
                .foregroundColor : UIColor(hex: 0x9A9696).withAlphaComponent(0.4)
            ]
        )
        
        view.font = UIFont.systemFont(ofSize: 16)
        view.layer.cornerRadius = 10
        view.addTarget(
            self,
            action: #selector(dismissKeyboard),
            for: .editingDidEndOnExit)
        return view
    }()
    

    private lazy var registerButton: UIButton = {
        let view = UIButton()
        view.configuration = .bordered()
        view.configuration?.title = "Login"
        view.configuration?.baseBackgroundColor = CroinColor.blue
        view.configuration?.baseForegroundColor = CroinColor.white
        view.configuration?.cornerStyle = .capsule
        
        return view
    }()
    
    func addSubviews() {
        view.addSubview(fieldsStackView)
        view.addSubview(registerButton)
        view.addSubview(logoView)
        view.addSubview(nameTextField)
    }
    
    func constraintSubviews() {
     //   constraintview()
        constraintRegisterButton()
        constraintFieldsStackView()
        constraintLogoImageView()
        constraintTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        view.backgroundColor = .croinColor.black
        self.addSubviews()
        self.constraintSubviews()
    }
    
    @objc
    private func handleTouch() {
        guard let name = nameTextField.text
        else { return }
        print(name)
    }
}

private extension LoginViewController {
    func constraintview() {
        view.layout {
            $0.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 24)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16)
        }
    }
    
    func constraintLogoImageView() {
        logoView.layout {
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.heightAnchor.constraint(equalToConstant: 56)
        }
    }
    
    
    func constraintFieldsStackView() {
        fieldsStackView.layout {
            $0.topAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.bottomAnchor.constraint(
                lessThanOrEqualTo: registerButton.topAnchor,
                constant: -Spacing.Horizontal.s3 + Spacing.Horizontal.s5)
        }
    }
    
    func constraintTextField() {
        nameTextField.layout {
            $0.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 16)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.heightAnchor.constraint(equalToConstant: 56)
        }
    }
    
    func constraintRegisterButton() {
        registerButton.layout {
            $0.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -100)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s3)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s3)
            $0.widthAnchor.constraint(equalToConstant: 200)
            $0.heightAnchor.constraint(equalToConstant: 100)
        }
    }
}

@objc
private extension LoginViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

