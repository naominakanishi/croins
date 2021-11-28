import UIKit

class NewCategoryViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    let categoryViewModel = CategoryViewModel()
    
    let pageTitle: UILabel = {
        let title = UILabel()
        title.text = "Nova Categoria"
        title.font = .boldSystemFont(ofSize: 25)
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var newCategoryEntryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
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
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "Gasto máximo",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    private lazy var openColorPickerButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        view.backgroundColor = .random()
        view.layer.cornerRadius = 10
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
        button.layer.cornerRadius = 10
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
        view.backgroundColor = .lightGray
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(pageTitle)
        view.addSubview(newCategoryEntryTextField)
        view.addSubview(targetEntryTextField)
        view.addSubview(openColorPickerButton)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        pageTitle.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        newCategoryEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 25)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        targetEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: newCategoryEntryTextField.bottomAnchor, constant: 25)
            $0.heightAnchor.constraint(equalTo: newCategoryEntryTextField.heightAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        openColorPickerButton.layout {
            $0.topAnchor.constraint(equalTo: targetEntryTextField.bottomAnchor, constant: 25)
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
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        openColorPickerButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        openColorPickerButton.backgroundColor = viewController.selectedColor
    }
    
}

@objc
private extension NewCategoryViewController {
    
    func openColorPicker() {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
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


extension UIColor {
    static func random() -> UIColor {
        .init(hex: .random(in: 0...0xFFFFFF))
    }
}
