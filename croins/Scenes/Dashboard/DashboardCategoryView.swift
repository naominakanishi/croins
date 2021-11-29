import UIKit

class DashboardCategoryView: UIView {
    struct Model {
        let categoryName: String
        let progress: ProgressView.Progress
    }
    
    let graph: ProgressView = {
        let view = ProgressView()
        return view
    }()
    
    private let targetLabel = TargetLabel()
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .preferredFont(forTextStyle: .caption1)
        view.textAlignment = .center
        view.textColor = .croinColor.white
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
        self.addSubview(graph)
        self.addSubview(targetLabel)
        self.addSubview(categoryLabel)
    }
    
    func constraintSubviews() {
        graph.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.widthAnchor.constraint(equalTo: widthAnchor)
            $0.heightAnchor.constraint(equalTo: widthAnchor)
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
        }
    
        targetLabel.layout {
            $0.centerXAnchor.constraint(equalTo: graph.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: graph.centerYAnchor)
            $0.topAnchor.constraint(equalTo: graph.topAnchor, constant: 35)
            $0.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant:-35)
        }
        
        categoryLabel.layout {
            $0.topAnchor.constraint(equalTo: graph.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
    
    func configure(using model: Model) {
        graph.render(progress: model.progress)
        targetLabel.configure(
            target: "\(model.progress.progress)/\(model.progress.total)", percentage: nil)
        categoryLabel.text = model.categoryName
    }
}
