import UIKit

class DashboardTransactionRecordView: UIView {
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Registro de informações"
        view.font = .boldSystemFont(ofSize: 25)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = CroinColor.white
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .equalSpacing
        return view
    }()
    
    private lazy var entryButton: TransactionButtons = {
        let view = TransactionButtons(label: "Entrada", image: "dashboard-entryButton")
        return view
    }()
    
    private lazy var spentButton: TransactionButtons = {
        let view = TransactionButtons(label: "Saída", image: "dashboard-spentButton")
        return view
    }()
    
    private lazy var cameraButton: TransactionButtons = {
        let view = TransactionButtons(label: "Camera", image: "dashboard-cameraButton")
        return view
    }()
    
    private lazy var voiceButton: TransactionButtons = {
        let view = TransactionButtons(label: "Camera", image: "dashboard-voiceButton")
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(title)
        self.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(entryButton)
        buttonsStackView.addArrangedSubview(spentButton)
        buttonsStackView.addArrangedSubview(cameraButton)
        buttonsStackView.addArrangedSubview(voiceButton)
    }
    
    func constraintSubviews() {
        title.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
        
        buttonsStackView.layout {
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
}
