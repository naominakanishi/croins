import UIKit

class CategoriesViewController: UIViewController {
    
    let categoryViewModel = CategoryViewModel()
    
    private lazy var pizzaChartView: PizzaChartView = {
        let view = PizzaChartView()
        
        return view
    }()
    
    private lazy var financialBalance: UIView = {
        let financialBalance = UIView()
        financialBalance.layer.borderWidth = 2
        financialBalance.layer.borderColor = CGColor(gray: 2, alpha: 1)
        financialBalance.layer.cornerRadius = 14
        return financialBalance
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pizzaChartView.configure(slices: [
            .init(percentage: 0.45, color: UIColor(named: "Lilac")!),
            .init(percentage: 0.25, color: UIColor(named: "Pink")!),
            .init(percentage: 0.23, color: UIColor(named: "Purple")!),
            .init(percentage: 0.08, color: UIColor(named: "Purple-2")!)
        ])
    }
    
    func configureNavigationBar() {
        title = "Categorias"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(onAddTapped))
    }
    
    func addSubviews() {
        view.addSubview(pizzaChartView)
        view.addSubview(financialBalance)
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
        return 10
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
            navigationController?.pushViewController(NewCategoryViewController(), animated: true)
        } else {
            navigationController?.pushViewController(ExpandedCategoryViewController(), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? CategoryViewCell)?.setupAdditionalSettings()
    }
}

@objc
private extension CategoriesViewController {
    func onAddTapped() {
        present(NewCategoryViewController(), animated: true, completion: nil)
    }
}


