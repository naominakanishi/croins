import UIKit

class ExpandedCategoryViewController: UIViewController {
    
    let graph: ProgressView = {
        let view = ProgressView(setup: .init(
            backgroundColor: .red.withAlphaComponent(0.1),
            tintColor: .blue
        ))
        return view
    }()
    
    private lazy var targetLabel: TargetLabel = {
        let view = TargetLabel()
        view.configure(target: "MOCK", percentage: "MOCK")
        return view
    }()
    
    private lazy var dateWindow: UILabel = {
        let view = UILabel()
        view.text = "01/fev - 26/fev"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var moneyMovementsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(MoneyMovementsTableViewCell.self, forCellReuseIdentifier: "MoneyMovementsTableViewCell")
        view.separatorStyle = .singleLine
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
        setupAdditionalSettings()
    }
    
    func configureNavigationBar() {
        title = "Comidas"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func addSubviews(){
        view.addSubview(graph)
        view.addSubview(targetLabel)
        view.addSubview(dateWindow)
        view.addSubview(moneyMovementsTableView)
    }
    
    func setupConstraints() {
        graph.layout {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
    
        targetLabel.layout {
            $0.centerXAnchor.constraint(equalTo: graph.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: graph.centerYAnchor)
            $0.topAnchor.constraint(equalTo: graph.topAnchor, constant: 35)
            $0.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant:-35)
        }
        
        dateWindow.layout {
            $0.topAnchor.constraint(equalTo: graph.bottomAnchor, constant: 20)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
        
        moneyMovementsTableView.layout {
            $0.topAnchor.constraint(equalTo: dateWindow.bottomAnchor, constant: 20)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
    }
    
    func setupAdditionalSettings() {
        graph.render(progress: .init(
            total: 10,
            progress: 9))
    }
    
    
}

extension ExpandedCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyMovementsTableViewCell") as! MoneyMovementsTableViewCell
//        let restaurantName = restaurantNames[indexPath.row]
//        cell.restaurantName.text = restaurantName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "+ Novo Gasto"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.textAlignment = .center
        
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onAddTapped))
            headerView.addGestureRecognizer(tapRecognizer)

            
            headerView.addSubview(label)
                  
            
            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
}

@objc
private extension ExpandedCategoryViewController {
    func onAddTapped() {
        present(NewEntryViewController(), animated: true, completion: nil)
    }
}
