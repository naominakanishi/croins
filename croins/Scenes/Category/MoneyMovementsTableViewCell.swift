import UIKit

class MoneyMovementsTableViewCell: UITableViewCell {
    
    struct Model {
        let transactionImage: UIImage?
        let transactionTitle: String
        let transactionValue: String
        let valueColor: UIColor?
        let transactionDescription: String
        let transactionDate: String
    }
    
    private lazy var transactionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        view.tintColor = .green
        return view
    }()
    
    private lazy var transactionLabel: UILabel = {
        let view = UILabel()
        view.text = "Dinheiro do tio Ernesto da Silva"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var transactionValue: UILabel = {
        let view = UILabel()
        view.text = "+320,00"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var transactionDescription: UILabel = {
        let view = UILabel()
        view.text = "freela"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var transactionDate: UILabel = {
        let view = UILabel()
        view.text = "23/05/2021"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .right
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(transactionImage)
        contentView.addSubview(transactionLabel)
        contentView.addSubview(transactionValue)
        contentView.addSubview(transactionDescription)
        contentView.addSubview(transactionDate)
    }
    
    func setupConstraints() {
        transactionImage.layout {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            $0.widthAnchor.constraint(equalToConstant: 24)
            $0.heightAnchor.constraint(equalTo: transactionImage.widthAnchor)
        }
        
        transactionLabel.layout {
            $0.leadingAnchor.constraint(equalTo: transactionImage.trailingAnchor, constant: 10)
            $0.bottomAnchor.constraint(equalTo: transactionValue.topAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        }
        
        transactionValue.layout {
            $0.leadingAnchor.constraint(equalTo: transactionImage.trailingAnchor, constant: 10)
            $0.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor)
            $0.centerYAnchor.constraint(equalTo: transactionImage.centerYAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        }
        
        transactionDescription.layout {
            $0.leadingAnchor.constraint(equalTo: transactionImage.trailingAnchor, constant: 10)
            $0.topAnchor.constraint(equalTo: transactionValue.bottomAnchor)
           
            $0.trailingAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
        
        transactionDate.layout {
            $0.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10)
            $0.topAnchor.constraint(equalTo: transactionValue.bottomAnchor)
            
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        }
    }
    
    func configure(using model: Model) {
        transactionImage.image = model.transactionImage
        transactionLabel.text = model.transactionTitle
        transactionValue.text = model.transactionValue
        transactionValue.textColor = model.valueColor
        transactionDescription.text = model.transactionDescription
        transactionDate.text = model.transactionDate
    }
}
