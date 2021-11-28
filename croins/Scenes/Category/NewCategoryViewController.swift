import UIKit

class NewCategoryViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
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
    
    private var headerView: EntryHeader

    
    let categoryViewModel = CategoryViewModel()
    
//    private lazy var leadingIcon: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "new-category-fill")
//        return view
//    }()
    
    func configureNavigationBar() {
        title = "Nova Categoria"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private lazy var nameQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Como você quer chamar a categoria?"
        return view
    }()
    
    private lazy var limitQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Qual limite mensal você quer estabelecer?"
        return view
    }()
    
    private lazy var colorQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Qual será a cor da categoria?"
        return view
    }()
    
    private lazy var newCategoryEntryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .hex(0xF5F6F8)
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
        view.backgroundColor = .hex(0xF5F6F8)
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
    
    private lazy var registerButton: UIButton = {
        let view = UIButton()
        view.configuration = .bordered()
        view.configuration?.title = "Registrar"
        view.configuration?.baseBackgroundColor = CroinColor.blue
        view.configuration?.baseForegroundColor = CroinColor.white
        view.configuration?.cornerStyle = .capsule
        
        return view
    }()
    
    init() {
        self.headerView = .init(title: "Nova Categoria", image: UIImage (named: "new-category-fill"))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CroinColor.black
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(nameQuestion)
        fieldsStackView.addArrangedSubview(newCategoryEntryTextField)
        fieldsStackView.addArrangedSubview(limitQuestion)
        fieldsStackView.addArrangedSubview(targetEntryTextField)
        fieldsStackView.addArrangedSubview(colorQuestion)
        fieldsStackView.addArrangedSubview(openColorPickerButton)
        fieldsStackView.addArrangedSubview(registerButton)
    }
    
    func setupConstraints() {
        containerView.layout {
            $0.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 0)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s4)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s4)
        }
        
        headerView.layout {
            $0.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Spacing.Horizontal.s3)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s2)

        }
        
        fieldsStackView.layout {
            $0.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.bottomAnchor.constraint(
                lessThanOrEqualTo: registerButton.topAnchor,
                constant: -Spacing.Horizontal.s3)
        }
        
        registerButton.layout {
            $0.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -Spacing.Horizontal.s3)
            $0.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.heightAnchor.constraint(equalToConstant: 56)
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
