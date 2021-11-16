import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    let graph: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle.circle")
        view.backgroundColor = .red
        return view
    }()
    let title: UILabel = {
        let view = UILabel()
        view.text = "Minha categoria"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    let target: UILabel = {
        let view = UILabel()
        view.text = "500/550"
        view.numberOfLines  = 0
        view.font = .systemFont(ofSize: 7)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100)
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
        
        target.layout {
            $0.centerXAnchor.constraint(equalTo: graph.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: graph.centerYAnchor)
            $0.widthAnchor.constraint(equalTo: graph.widthAnchor, multiplier: 0.5)
        }
        
        title.layout {
            $0.topAnchor.constraint(equalTo: graph.bottomAnchor, constant: 20)
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
    }
}
