import UIKit
import DropDown

class NewEntryViewController: UIViewController {

    let inputViewModel = InputViewModel()
    
    let pageTitle: UILabel = {
        let pageTitle = UILabel()
        pageTitle.text = "Perdoa, gastei a grana"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 25)
        pageTitle.numberOfLines = 0
        return pageTitle
    }()
    
    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        stackView.layer.cornerRadius = 30
        return stackView
    }()
    
    private lazy var spentEntryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "Com o que gastou",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)
        ])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    
    
    
    
    let costTitle: UILabel = {
        let costTitle = UILabel()
        costTitle.text = "Custou"
        costTitle.font = UIFont.systemFont(ofSize: 15)
        costTitle.numberOfLines = 0
        costTitle.textAlignment = .center
        return costTitle
    }()
    
    let categoryTitle: UILabel = {
        let categoryTitle = UILabel()
        categoryTitle.text = "Categoria"
        categoryTitle.font = UIFont.systemFont(ofSize: 15)
        categoryTitle.numberOfLines = 0
        categoryTitle.textAlignment = .center
        return categoryTitle
    }()
    
    private lazy var amountSpentTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "$$",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)
        ])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    /// Substituir por um DropDown de categorias
    /*private lazy var categoryTextField: WSTagsField = {
        let view = WSTagsField()
        view.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.spaceBetweenLines = 5.0
        view.spaceBetweenTags = 10.0
        view.font = .systemFont(ofSize: 12.0)
        view.backgroundColor = .white
        view.tintColor = .green
        view.textColor = .black
        view.textColor = .blue
        view.selectedColor = .black
        view.selectedTextColor = .red
        view.isDelimiterVisible = false
        view.placeholderColor = .green
        view.placeholderAlwaysVisible = true
        view.acceptTagOption = .space
        view.shouldTokenizeAfterResigningFirstResponder = true
        view.placeholder = "Categoria"
        view.numberOfLines = 1
        view.enableScrolling = true
        
        view.onDidRemoveTag = { tagField, tag in
            // Adicionar código para retirar as tags de todas os inputs realizados
            // inputViewModel.dataInputInList.filter({ $0.category == tag })
        }
        
        view.onValidateTag = { tag, tags in
            return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
        }
        
        /*view.onDidSelectTagView = { field, tag in
            let tagText = tagsField.tagViews.filter{ $0 == tag }.first!.displayText
            // Tem como passar por referência? Ao excluir, tira do input também
            self.categoriaTeste.addCategoria(tagsField.tags.first(where: { $0.text == tagText })!)
            self.pageTitle.text = self.categoriaTeste.categoria.text
        }*/
        
        return view
    }()*/

    
    private lazy var paymentMethodTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "Forma de pagamento",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)
        ])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .compact
        view.backgroundColor = .white
//        view.tintColor = .white
        
        view.locale = .current
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(handleDateDidChange), for: .valueChanged)
        return view
    }()
    
    private lazy var recurrentPicker: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePickerTap))
        view.addGestureRecognizer(tap)
        

        return view
    }()
    
    private lazy var recurrentPickerLabel: UILabel = {
        let view = UILabel()
        view.text = "Essa transação é recorrente?"
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var dropDown: DropDown = {
        let view = DropDown()
        view.anchorView = recurrentPicker
        view.dataSource = recurrencyOptions
        view.bottomOffset = CGPoint(x: 0, y:(view.anchorView?.plainView.bounds.height)!)
        return view
    }()
    
    let recurrencyOptions = ["Não é recorrente", "Mensal", "Quinzenal", "Mensal", "Anual"]
    
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
        view.addSubview(inputStackView)
        view.addSubview(spentEntryTextField)
        view.addSubview(costTitle)
        view.addSubview(categoryTitle)
        view.addSubview(amountSpentTextField)
        view.addSubview(paymentMethodTextField)
        view.addSubview(datePicker)
        view.addSubview(recurrentPicker)
        view.addSubview(recurrentPickerLabel)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        //MARK: page title constraints
        pageTitle.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        inputStackView.layout{
            //$0.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 100)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        }
        
        spentEntryTextField.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: inputStackView.topAnchor, constant: 20)
        }

        costTitle.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.5)
            $0.trailingAnchor.constraint(equalTo: inputStackView.centerXAnchor, constant: 0)
            $0.topAnchor.constraint(equalTo: spentEntryTextField.bottomAnchor, constant: 20)
        }
        
        categoryTitle.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.5)
            $0.leadingAnchor.constraint(equalTo: inputStackView.centerXAnchor, constant: 00)
            $0.topAnchor.constraint(equalTo: spentEntryTextField.bottomAnchor, constant: 20)
        }
        
        amountSpentTextField.layout {
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3)
            $0.centerXAnchor.constraint(equalTo: costTitle.centerXAnchor, constant: 0)
            $0.topAnchor.constraint(equalTo: costTitle.bottomAnchor, constant: 10)
        }
        
        paymentMethodTextField.layout {
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: amountSpentTextField.bottomAnchor, constant: 20)
        }
        
        datePicker.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: paymentMethodTextField.bottomAnchor, constant: 20)
        }
            
        recurrentPicker.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20)
            $0.heightAnchor.constraint(equalToConstant: 40)
        }
        
        recurrentPickerLabel.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: recurrentPicker.centerYAnchor)
            $0.heightAnchor.constraint(equalToConstant: 40)
        }

        saveButton.layout{
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            $0.heightAnchor.constraint(equalToConstant: 40)
        }
    }
    
    
    
   
}


@objc
private extension NewEntryViewController {

    func saveButtonTap() {
        
        inputViewModel.writeIncomeData(title: spentEntryTextField.text ?? "",
                                       gain: amountSpentTextField.text ?? "",
                                       method: Method(title: paymentMethodTextField.text ?? "", installments: 0),
                                       date: datePicker.date,
                                       isRecurrent: false)
    }
    
    
    func handlePickerTap(_ sender: UITapGestureRecognizer? = nil){
        dropDown.show()
    }
    
    func handleDateDidChange() {
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
}

