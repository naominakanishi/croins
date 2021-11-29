import UIKit

class DashboardCategoriesView: UIView {
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Categorias"
        view.font = .preferredFont(forTextStyle: .body)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.textColor = .croinColor.offwhite
        return view
    }()
    
    private lazy var categoriesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        view.distribution = .fill
        return view
    }()
    
    private lazy var firstCategory = DashboardCategoryView()
    
    private lazy var secondCategory = DashboardCategoryView()
    
    private lazy var thirdCategory = DashboardCategoryView()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        self.layer.cornerRadius = 20
        layer.borderColor = CroinColor.green.withAlphaComponent(0.15).cgColor
        layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(title)
        self.addSubview(categoriesStackView)
        categoriesStackView.addArrangedSubview(firstCategory)
        categoriesStackView.addArrangedSubview(secondCategory)
        categoriesStackView.addArrangedSubview(thirdCategory)
    }
    
    func constraintSubviews() {
        title.layout {
            $0.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.Vertical.s4)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
        
        categoriesStackView.layout {
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Spacing.Horizontal.s4)
            $0.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16)
            $0.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16)
            $0.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8)
        }
    }
    
    func configure(using categories: [DashboardCategoryView.Model]) {
        let views =  [
            firstCategory,
            secondCategory,
            thirdCategory
        ]
        zip(categories, views).forEach { $1.configure(using: $0) }
    }
}
