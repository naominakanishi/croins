import UIKit

protocol NewEntryViewDelegate: AnyObject {
    func didTapOnButton(
        name: String,
        when: Date,
        howMuch: Money,
        categoryIndex: Int?
    )
}

final class NewEntryView: UIView {
    
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
    
//    private lazy var titleStackView: UIStackView = {
//        let view = UIStackView()
//        view.axis = .horizontal
//        view.spacing = 10
//        return view
//    }()
//    
    private let headerView: EntryHeader
    
    private lazy var nameQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Como você quer chamar a transação?"
        return view
    }()
    
    private lazy var costQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Qual o valor dessa transação?"
        return view
    }()
    
    private lazy var whenQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Quando ocorreu essa transação?"
        return view
    }()
    
    private lazy var categoryQuestion: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .left
        view.textColor = .black
        view.text = "Essa transação pertence a alguma categoria?"
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .hex(0xF5F6F8)
        view.attributedPlaceholder = .init(
            string: "Nome do gasto",
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
    
    private lazy var costTextField: NumberFormattedTextField = {
        let view = NumberFormattedTextField(inset: 15)
        view.backgroundColor = UIColor(
            hex: 0xF5F6F8)
        view.attributedPlaceholder = .init(
            string: "Quanto custou",
            attributes: [
                .font : UIFont.systemFont(ofSize: 12),
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
    
    private lazy var whenTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .hex(0xF5F6F8)
        view.attributedPlaceholder = .init(
            string: "Selecionar data",
            attributes: [
                .font : UIFont.systemFont(ofSize: 16),
                .foregroundColor : UIColor(hex: 0x9A9696).withAlphaComponent(0.4)
            ]
        )
        view.datePicker(
            target: self,
            doneAction: #selector(handleDonePickingDate),
            cancelAction: #selector(handleDonePickingDidCancel))
        return view
    }()
    
    private lazy var categoriesDropdown: DropdownPicker = {
        let view = DropdownPicker()
        view.placeholder = "Selecionar categoria"
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
    
    private weak var delegate: NewEntryViewDelegate?
    
    init(
        dropdownDataSource: DropdownDataSource,
        delegate: NewEntryViewDelegate,
        title: String,
        headerImage: UIImage?,
        isCategoryHidden: Bool = false,
        frame: CGRect = .zero
    ) {
        self.delegate = delegate
        self.headerView = .init(title: title, image: headerImage)
        super.init(frame: frame)
        categoriesDropdown.dataSource = dropdownDataSource
        addSubviews()
        constraintSubviews()
        categoriesDropdown.isHidden = isCategoryHidden
        categoryQuestion.isHidden = isCategoryHidden
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(fieldsStackView)
        containerView.addSubview(registerButton)
        fieldsStackView.addArrangedSubview(nameQuestion)
        fieldsStackView.addArrangedSubview(nameTextField)
        fieldsStackView.addArrangedSubview(costQuestion)

        fieldsStackView.addArrangedSubview(costTextField)
        
        fieldsStackView.addArrangedSubview(whenQuestion)
        fieldsStackView.addArrangedSubview(whenTextField)
        
        fieldsStackView.addArrangedSubview(categoryQuestion)
        fieldsStackView.addArrangedSubview(categoriesDropdown)
    }
    
    func constraintSubviews() {
        constraintContainerView()
        constraintHeaderView()
        constraintRegisterButton()
        constraintFieldsStackView()
        
    }
    
    func reloadCategories() {
        categoriesDropdown.reloadOptions()
    }
    
    @objc
    private func handleTouch() {
        guard let name = nameTextField.text,
              let datePicker = whenTextField.inputView as? UIDatePicker
        else { return }
        
        delegate?.didTapOnButton(
            name: name,
            when: datePicker.date,
            howMuch: costTextField.amount,
            categoryIndex: categoriesDropdown.currentSelectedIndex)
    }
}


private extension NewEntryView {
    func constraintContainerView() {
        containerView.layout {
            $0.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24)
            $0.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16)
            $0.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16)
        }
    }
    
    func constraintHeaderView() {
        headerView.layout {
            $0.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 16)
            $0.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 16)
            $0.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -16)

        }
    }
    
    func constraintRegisterButton() {
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
    
    func constraintFieldsStackView() {
        fieldsStackView.layout {
            $0.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Spacing.Vertical.s2)
            $0.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Spacing.Vertical.s2)
            $0.bottomAnchor.constraint(
                lessThanOrEqualTo: registerButton.topAnchor,
                constant: -Spacing.Horizontal.s3 + Spacing.Horizontal.s5)
        }
    }
}

@objc
private extension NewEntryView {
    func dismissKeyboard() {
        endEditing(true)
    }
    
    func handleDonePickingDate() {
        guard let datePicker = whenTextField.inputView as? UIDatePicker
        else { return }
        let pickedDate = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        whenTextField.text = formatter.string(from: pickedDate)
        whenTextField.resignFirstResponder()
    }
    
    func handleDonePickingDidCancel() {
        whenTextField.resignFirstResponder()
    }
}
