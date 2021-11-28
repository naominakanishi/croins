import UIKit
import Intents
import IntentsUI

final class SuccessfulRegisterViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
    
    var inputViewModel = InputViewModel()
    
    private lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var entryHeader: EntryHeader = {
        EntryHeader(title: inputViewModel.inputModel.title, image: inputViewModel.inputModel.image)
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
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(entryHeader)
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
        entryHeader.layout {
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20)
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20)
        }
        
        confirmationImageView.layout {
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: entryHeader.bottomAnchor, constant: 12)
            $0.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.4)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1)
        }
        
        confirmationLabel.layout {
            $0.centerXAnchor.constraint(equalTo: entryHeader.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: entryHeader.widthAnchor)
            $0.topAnchor.constraint(equalTo: confirmationImageView.bottomAnchor, constant: 12)
        }
        
        buttonsStackView.layout {
            $0.widthAnchor.constraint(equalTo: entryHeader.widthAnchor)
            $0.centerXAnchor.constraint(equalTo: entryHeader.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20)
            $0.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20)
        }
    }
}

extension SuccessfulRegisterViewController {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func donateInteraction() {
        let intent = CreateExpenseIntent()
        intent.suggestedInvocationPhrase = inputViewModel.newExpenseDonation.suggestedInvocationPhrase
        intent.title = inputViewModel.newExpenseDonation.title
        intent.value = NSNumber(value: inputViewModel.newExpenseDonation.value)
        intent.date = inputViewModel.newExpenseDonation.date
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { (error) in
            if let error = error as NSError? {
                print("Interaction donation failed: \(error.description)")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}

@objc
private extension SuccessfulRegisterViewController {
    func handleConfirmButtonTap(_ sender: Any) {
        donateInteraction()
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleSiriButtonTap(_ sender: Any) {
        if let shortcut = INShortcut(intent: inputViewModel.inputModel.siriIntent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self
            present(viewController, animated: true, completion: nil)
        }
    }
}
