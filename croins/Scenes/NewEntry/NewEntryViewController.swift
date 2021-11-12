import UIKit
import DropDown

class NewEntryViewController: UIViewController {

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
    
    var name: String? { spentEntryTextField.text }
    
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
    
    private lazy var categoryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "tag",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)
        ])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
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
        view.locale = .current
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
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
        pageTitle.text = "Essa transação é recorrente?"
        pageTitle.font = UIFont.systemFont(ofSize: 14)
        pageTitle.numberOfLines = 0
        return view
    }()
    
    lazy var dropDown: DropDown = {
        let view = DropDown()
        view.anchorView = recurrentPicker
        view.dataSource = recurrencyOptions
        view.bottomOffset = CGPoint(x: 0, y:(view.anchorView?.plainView.bounds.height)!)
//        view.selectionAction = { [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)"))
//            recurrentPickerLabel.text = recurrencyOptions[index]
//        }
        
        return view
    }()
    
    let recurrencyOptions = ["Não é recorrente", "Mensal", "Quinzenal", "Mensal", "Anual"]
    
    
    
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
        view.addSubview(categoryTextField)
        view.addSubview(paymentMethodTextField)
        view.addSubview(datePicker)
        view.addSubview(recurrentPicker)
        view.addSubview(recurrentPickerLabel)
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
        
        categoryTextField.layout{
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.3)
            $0.centerXAnchor.constraint(equalTo: categoryTitle.centerXAnchor, constant: 0)
            $0.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 10)
        }
        
        paymentMethodTextField.layout {
            $0.widthAnchor.constraint(equalTo: inputStackView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 20)
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
            $0.centerYAnchor.constraint(equalTo: recurrentPicker.centerYAnchor, constant: 20)
            $0.heightAnchor.constraint(equalToConstant: 40)
        }
    }
    
    
    
   
}


@objc
private extension NewEntryViewController {

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

