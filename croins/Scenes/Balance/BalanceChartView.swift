import UIKit

class BalanceChartView: UIView {
    
    struct Bar {
        let inPercentage: Double
        let outPercentage: Double
        let dateRange: String
        let balance: String
        let balanceColor: UIColor?
        let isSelected: Bool
    }
    
    var bars: [Bar] = []
    
    private lazy var chartCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var pinkTraceView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var greenTraceView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(chartCollectionView)
        chartCollectionView.addSubview(pinkTraceView)
        chartCollectionView.addSubview(greenTraceView)
        chartCollectionView.addSubview(bottomLine)
    }
    
    private func setupConstraints() {
        chartCollectionView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
    }

    
}

extension BalanceChartView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bars.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        .init()
    }
}
