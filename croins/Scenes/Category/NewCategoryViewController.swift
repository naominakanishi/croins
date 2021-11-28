import UIKit

class NewCategoryViewController: UIViewController {
    
    let categoryViewModel = CategoryViewModel()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private lazy var headerView: EntryHeader = {
        let view = EntryHeader(title: "Nova Categoria", image: UIImage(systemName: "circle"))
        return view
    }()
    
//    let pageTitle: UILabel = {
//        let title = UILabel()
//        title.text = "Nova Categoria"
//        title.font = .boldSystemFont(ofSize: 25)
//        title.numberOfLines = 0
//        return title
//    }()
    
    private lazy var newCategoryEntryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .gray
        view.attributedPlaceholder = .init(string: "Nome da categoria",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    private lazy var targetEntryTextField: NumberFormattedTextField = {
        let view = NumberFormattedTextField(inset: 15)
        view.backgroundColor = .gray
        view.attributedPlaceholder = .init(string: "Gasto máximo",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(newCategoryEntryTextField)
        containerView.addSubview(targetEntryTextField)
        containerView.addSubview(saveButton)
    }
    
    func setupConstraints() {
        
        containerView.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -24)
        }
        
        headerView.layout {
            $0.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 16)
            $0.leadingAnchor.constraint( equalTo: containerView.leadingAnchor,constant: 16)
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -16)
            
        }
        
        newCategoryEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        targetEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: newCategoryEntryTextField.bottomAnchor, constant: 25)
            $0.heightAnchor.constraint(equalTo: newCategoryEntryTextField.heightAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        saveButton.layout {
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.heightAnchor.constraint(equalToConstant: 40)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
    }
}

@objc
private extension NewCategoryViewController {
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupKeyboardDismissGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard)
        ))
    }
    
    func removeKeyboardDismissGesture() {
        view.gestureRecognizers?
            .filter { $0 is UITapGestureRecognizer }
            .forEach(view.removeGestureRecognizer)
    }
    
    func saveButtonTap() {
        guard let title = newCategoryEntryTextField.text
        else { return }
        categoryViewModel.addNewCategory(
            Category(
                title: title,
                target: targetEntryTextField.amount
            ))
    }
}

