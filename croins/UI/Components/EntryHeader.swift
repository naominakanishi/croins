import UIKit

final class EntryHeader: UIView {
    private lazy var titleIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        return view
    }()
    
    private lazy var titleText: UILabel = {
        let view = UILabel()
        view.text = "Perdoa Gastei"
        view.font = .boldSystemFont(ofSize: 25)
        view.numberOfLines = 0
        return view
    }()
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        addSubviews()
        constraintSubviews()
        titleText.text = title
        titleIcon.image = image

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(titleIcon)
        self.addSubview(titleText)
    }
    
    func constraintSubviews() {
        titleIcon.layout {
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            $0.heightAnchor.constraint(equalToConstant: 21)
            $0.widthAnchor.constraint(equalToConstant: 21)
        }
        
        titleText.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor)
            $0.leadingAnchor.constraint(equalTo: titleIcon.trailingAnchor, constant: 10)
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
           
        }
    }
}
