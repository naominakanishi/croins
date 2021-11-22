import UIKit

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
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    private lazy var headerView: EntryHeader = {
        let view = EntryHeader(title: "Perdoa gastei", image: UIImage(systemName: "circle"))
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
    
    private lazy var coastTextField: NumberFormattedTextField = {
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
        view.configuration?.title = "Registrar gastos"
        view.configuration?.baseForegroundColor = .blue
        return view
    }()
    
    init(
        dropdownDataSource: DropdownDataSource,
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        categoriesDropdown.dataSource = dropdownDataSource
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(fieldsStackView)
        containerView.addSubview(registerButton)
        fieldsStackView.addArrangedSubview(nameTextField)
        fieldsStackView.addArrangedSubview(coastTextField)
        fieldsStackView.addArrangedSubview(whenTextField)
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
            $0.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -24)
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
                constant: -16)
            $0.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 24)
            $0.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -16)
        }
    }
    
    func constraintFieldsStackView() {
        fieldsStackView.layout {
            $0.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 16)
            $0.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 16)
            $0.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -16)
            $0.bottomAnchor.constraint(
                lessThanOrEqualTo: registerButton.topAnchor,
                constant: -16)
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
