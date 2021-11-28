import UIKit

final class TargetLabel: UIView {

    private lazy var target: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 10)
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    
    private lazy var targetPercentage: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .center
        view.textColor = .white
        
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
        self.addSubview(target)
        self.addSubview(targetPercentage)
    }
    
    func constraintSubviews() {
        target.layout {
            $0.topAnchor.constraint(equalTo: self.topAnchor)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        }
        
        targetPercentage.layout{
            $0.topAnchor.constraint(equalTo: target.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        }
    }
    
    func configure(target: String, percentage: String?) {
        self.target.text = target
        targetPercentage.text = percentage
    }
}
