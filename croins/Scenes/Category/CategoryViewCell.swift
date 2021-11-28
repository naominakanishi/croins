import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    private lazy var graph: ProgressView = {
        let view = ProgressView(setup: .init(
            backgroundColor: .red.withAlphaComponent(0.1),
            tintColor: .blue
        ))
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Minha categoria"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    private lazy var target: UILabel = {
        let view = UILabel()
        view.text = "500/550"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 7)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupAdditionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(graph)
        contentView.addSubview(title)
        contentView.addSubview(target)
    }
    
    func setupConstraints() {
        graph.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }
        
        target.layout {
            $0.centerXAnchor.constraint(equalTo: graph.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: graph.centerYAnchor)
            $0.topAnchor.constraint(equalTo: graph.topAnchor, constant: 35)
            $0.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant:-35)
        }
        
        title.layout {
            $0.topAnchor.constraint(equalTo: graph.bottomAnchor, constant: 10)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            $0.leadingAnchor.constraint(equalTo: graph.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: graph.trailingAnchor)
        }
    }
    
    func setupAdditionalSettings() {
        graph.render(progress: .init(
            total: 10,
            progress: 20.5))
    }
}
