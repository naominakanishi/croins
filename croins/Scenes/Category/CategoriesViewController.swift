import UIKit

class CategoriesViewController: UIViewController {
    
    let categoryViewModel = CategoryViewModel()
    
    private lazy var pizzaChartView: PizzaChartView = {
        let view = PizzaChartView()
        
        return view
    }()
    
    private lazy var categoriesList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CategoryViewCell.self, forCellWithReuseIdentifier: "CategoryViewCell")
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
        view.backgroundColor = .lightGray
        configureNavigationBar()
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pizzaChartView.configure(slices: [
            .init(percentage: 0.15, color: .blue),
            .init(percentage: 0.30, color: .black),
            .init(percentage: 0.10, color: .orange),
            .init(percentage: 0.05, color: .green),
            .init(percentage: 0.33, color: .purple),
            .init(percentage: 0.07, color: .systemPink),
        ])
    }
    
    func configureNavigationBar() {
        title = "Categoriassssss"
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
        view.addSubview(categoriesList)
    }
    
    func setupConstraints() {
        
        pizzaChartView.layout {
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            $0.heightAnchor.constraint(equalTo: pizzaChartView.widthAnchor)
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        }
        
        categoriesList.layout {
            $0.topAnchor.constraint(equalTo: pizzaChartView.bottomAnchor, constant: 30)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ExpandedCategoryViewController(), animated: true)
       
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

