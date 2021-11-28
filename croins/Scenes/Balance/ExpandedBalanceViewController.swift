import UIKit

class ExpandedBalanceViewController: UIViewController {
    
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
        
    }
    
    func configureNavigationBar() {
        title = "NOME DO MES"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.rightBarButtonItem = .init(
//            image: .init(systemName: "plus"),
//            style: .done,
//            target: self,
//            //action: #selector(onAddTapped))
    }
    
    func addSubviews() {
        view.addSubview(moneyMovementsTableView)
    }
    
    func setupConstraints() {
        moneyMovementsTableView.layout {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
    }
    
}

extension ExpandedBalanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyMovementsTableViewCell") as! MoneyMovementsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = "+ Nova transação"
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
private extension ExpandedBalanceViewController {
    func onAddTapped() {
        present(NewEntryViewController(), animated: true, completion: nil)
    }
}
