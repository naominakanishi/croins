import UIKit

class NewCategoryViewCell: UICollectionViewCell {
    
    var newCategoryBorder: CAShapeLayer!
    var label = UILabel()
    var plusIcon = UIImageView()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Nova Categoria"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        //setupBorder()
        setupPlusIcon()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView
            .addSubview(newCellView)
        contentView
            .addSubview(newCellLabel)
    }
    
    private lazy var newCellView: UIView = {
        let newCellView = UIView()
        newCellView.layer.borderWidth = 2
        newCellView.layer.borderColor = CGColor(gray: 2, alpha: 0.6)
        newCellView.layer.cornerRadius = 45.5
        return newCellView
    }()
    
    
    private lazy var newCellPlusIcon: UIView = {
        let newCellPlusIcon = UIView()
      
        return newCellPlusIcon
    }()
    
    
    private lazy var newCellLabel: UILabel = {
        let newCellLabel = UILabel()
        newCellLabel.text = "Adicionar"
        newCellLabel.font = .systemFont(ofSize: 12)
        newCellLabel.textColor = .white
        return newCellLabel
    }()
        
    func setupBorder() {
        newCategoryBorder = CAShapeLayer()
        newCategoryBorder.lineWidth = 1
        newCategoryBorder.strokeColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        newCategoryBorder.lineDashPattern = [10, 8] as [NSNumber]
        newCategoryBorder.frame = bounds
        newCategoryBorder.fillColor = nil
        newCategoryBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 100).cgPath
        self.contentView.layer.addSublayer(newCategoryBorder)
    }
    
    func setupPlusIcon() {
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(plusIcon)
        plusIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        plusIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35).isActive = true
        plusIcon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        plusIcon.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        plusIcon.tintColor = .white
    }
    
    func setupConstraints() {
        newCellView.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            $0.heightAnchor.constraint(equalToConstant: 91)
            $0.widthAnchor.constraint(equalToConstant: 91)
            
        }
        
        newCellLabel.layout {
            $0.topAnchor.constraint(equalTo: newCellView.bottomAnchor, constant: 10)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
    }
}
