import UIKit

class ExpandedCategoryViewController: UIViewController {
    
    let graph: ProgressView = {
        let view = ProgressView(setup: .init(
            backgroundColor: .red.withAlphaComponent(0.1),
            tintColor: .blue
        ))
        return view
    }()
    
    let target: UILabel = {
        let view = UILabel()
        view.text = "500/550"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 7)
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureNavigationBar()
        addSubviews()
        setupConstraints()
        
    }
    
    func configureNavigationBar() {
        title = "Comidas"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.rightBarButtonItem = .init(
//            image: .init(systemName: "plus"),
//            style: .done,
//            target: self,
//            //action: #selector(onAddTapped))
    }
    
    func addSubviews(){
        view.addSubview(graph)
        view.addSubview(target)
    }
    
    func setupConstraints() {
        graph.layout {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }
    
        target.layout {
        $0.centerXAnchor.constraint(equalTo: graph.centerXAnchor)
        $0.centerYAnchor.constraint(equalTo: graph.centerYAnchor)
        $0.topAnchor.constraint(equalTo: graph.topAnchor, constant: 35)
        $0.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant:-35)
        }
    }
}
