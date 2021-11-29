import UIKit

class CategoriesViewController: UIViewController {
    
    private var categoryList: [Category] = AppDatabase.shared.categories ?? []
    
    private lazy var pizzaChartView: PizzaChartView = {
        let view = PizzaChartView()
        
        return view
    }()
    
    private lazy var financialBalance: UIView = {
        let financialBalance = UIView()
        financialBalance.layer.borderWidth = 2
        financialBalance.layer.borderColor = CGColor(gray: 2, alpha: 0.4)
        financialBalance.layer.cornerRadius = 14
        return financialBalance
    }()
    
    private lazy var availableLimitLabel: UILabel = {
        let availableLimitLabel = UILabel()
        availableLimitLabel.text = "Limite Disponível"
        availableLimitLabel.font = .systemFont(ofSize: 14)
        availableLimitLabel.textColor = .white
        return availableLimitLabel
    }()
    
    private lazy var availableLimitResultUILabel: UILabel = {
        let availableLimitResultUILabel = UILabel()
        availableLimitResultUILabel.text = "$432,00"
        availableLimitResultUILabel.font = .systemFont(ofSize: 14)
        availableLimitResultUILabel.textColor = .white
        return availableLimitResultUILabel
    }()
    
    private lazy var maximumLimitLabelUILabel: UILabel = {
        let maximumLimitLabelUILabel = UILabel()
        maximumLimitLabelUILabel.text = "Limite Máximo"
        maximumLimitLabelUILabel.font = .systemFont(ofSize: 14)
        maximumLimitLabelUILabel.textColor = .white
        return maximumLimitLabelUILabel
    }()
    
    private lazy var maximumLimitResultUILabel: UILabel = {
        let maximumLimitResultUILabel = UILabel()
        maximumLimitResultUILabel.text = "$1.723,00"
        maximumLimitResultUILabel.font = .systemFont(ofSize: 14)
        maximumLimitResultUILabel.textColor = .white
        return maximumLimitResultUILabel
    }()

    private lazy var categoriesList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CategoryViewCell.self, forCellWithReuseIdentifier: "CategoryViewCell")
        view.register(NewCategoryViewCell.self, forCellWithReuseIdentifier: "NewCategoryViewCell")
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
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
        view.backgroundColor = UIColor(named: "Background")!
        configureNavigationBar()
        addSubviews()
        setupConstraints()
        AppDatabase.shared.subscribe(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pizzaChartView.configure(slices: [
            .init(percentage: 0.45, color: UIColor(named: "Lilac")!),
            .init(percentage: 0.25, color: UIColor(named: "Pink")!),
            .init(percentage: 0.23, color: UIColor(named: "Purple")!),
            .init(percentage: 0.08, color: UIColor(named: "Purple-2")!)
        ])
        categoriesList.reloadData()
    }
    
    func configureNavigationBar() {
        title = "Categorias"
        navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(onAddTapped))
    }
    
    func addSubviews() {
        view.addSubview(pizzaChartView)
        view.addSubview(financialBalance)
        view.addSubview(availableLimitLabel)
        view.addSubview(availableLimitResultUILabel)
        view.addSubview(maximumLimitLabelUILabel)
        view.addSubview(maximumLimitResultUILabel)
        view.addSubview(categoriesList)
    }
    
    func setupConstraints() {
        
        pizzaChartView.layout {
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            $0.heightAnchor.constraint(equalTo: pizzaChartView.widthAnchor)
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        }
        
        financialBalance.layout {
            $0.topAnchor.constraint(equalTo: pizzaChartView.bottomAnchor, constant: 30)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.heightAnchor.constraint(equalToConstant: 64)
        }
        
        availableLimitLabel.layout {
            $0.topAnchor.constraint(equalTo: financialBalance.topAnchor, constant: -10)
            $0.widthAnchor.constraint(equalTo: financialBalance.widthAnchor, multiplier: 0.45)
            $0.heightAnchor.constraint(equalTo: financialBalance.heightAnchor)
            $0.leadingAnchor.constraint(equalTo: financialBalance.leadingAnchor, constant: 24)
        }
        
        availableLimitResultUILabel.layout {
            $0.topAnchor.constraint(equalTo: availableLimitLabel.bottomAnchor, constant: -45)
            $0.widthAnchor.constraint(equalTo: financialBalance.widthAnchor, multiplier: 0.45)
            $0.heightAnchor.constraint(equalTo: financialBalance.heightAnchor)
            $0.centerXAnchor.constraint(equalTo: availableLimitLabel.centerXAnchor)
        }
        
        maximumLimitLabelUILabel.layout {
            $0.topAnchor.constraint(equalTo: financialBalance.topAnchor, constant: -10)
            $0.widthAnchor.constraint(equalTo: financialBalance.widthAnchor, multiplier: 0.45)
            $0.heightAnchor.constraint(equalTo: financialBalance.heightAnchor)
            $0.trailingAnchor.constraint(equalTo: financialBalance.trailingAnchor, constant: 10)
        }
        
        maximumLimitResultUILabel.layout {
            $0.topAnchor.constraint(equalTo: maximumLimitLabelUILabel.bottomAnchor, constant: -45)
            $0.widthAnchor.constraint(equalTo: financialBalance.widthAnchor, multiplier: 0.45)
            $0.heightAnchor.constraint(equalTo: financialBalance.heightAnchor)
            $0.centerXAnchor.constraint(equalTo: maximumLimitLabelUILabel.centerXAnchor)
        }
        
        categoriesList.layout {
            $0.topAnchor.constraint(equalTo: financialBalance.bottomAnchor, constant: 30)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCategoryViewCell", for: indexPath) as! NewCategoryViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let controller = NewCategoryViewController()
//            controller.categoryViewModel = categoryViewModel //TODO
            navigationController?.pushViewController(controller, animated: true)
        } else {
            navigationController?.pushViewController(ExpandedCategoryViewController(), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = (cell as? CategoryViewCell)
        guard indexPath.item > 0 else { return }
        let item = categoryList[indexPath.item - 1]
        let current = AppDatabase.shared.progress(for: item)
        
        cell?.configure(using: .init(
            title: item.title,
            target: "\(current)/\(item.target)",
            progress: .init(
                total: item.target,
                progress: current / item.target)))
    }
}

@objc
private extension CategoriesViewController {
    func onAddTapped() {
        let controller = NewCategoryViewController()
//        controller.categoryViewModel = categoryViewModel // TODO
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CategoriesViewController: DatabaseSubscriber {
    func onDatabaseChange() {
        let db = AppDatabase.shared
        self.categoryList = db.categories
        categoriesList.reloadData()
    }
}
