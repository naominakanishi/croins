import UIKit

class BalanceChartView: UIView {
    
    typealias Bar = BarCollectionViewCell.Bar
    
    var bars: [Bar] = []
    
    private lazy var chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(BarCollectionViewCell.self)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        
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
        backgroundColor = .clear
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
    
    func configure(using bars: [Bar]) {
        self.bars = bars
        chartCollectionView.reloadSections(.init(integer: 0))
    }
    
    func scrollToEnd() {
        chartCollectionView.scrollToItem(
            at: .init(item: bars.count, section: 0),
            at: .right,
            animated: true)
    }
}

extension BalanceChartView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bars.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(BarCollectionViewCell.self, at: indexPath)
        switch indexPath.item {
        case 0..<bars.count:
            cell.configure(using: bars[indexPath.item])
        default:
            cell.configure(using: .init(
                inPercentage: 0,
                outPercentage: 0,
                dateRange: " ",
                balance: " ",
                balanceColor: .clear,
                isSelected: false,
                date: Date()))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(
            width: collectionView.frame.width * 0.3,
            height: collectionView.frame.height)
    }
}

protocol Reusable {}

extension Reusable where Self: NSObject {
    static var reuseIdentifier: String { String(describing: self) }
}

extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    func register<CellType>(_ type: CellType.Type) where CellType: UICollectionViewCell {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeue<CellType>(_ type: CellType.Type, at indexPath: IndexPath) -> CellType where CellType: UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath) as? CellType
        else {
                fatalError("Register the cell for type \(CellType.reuseIdentifier)")
            }
        
        return cell
    }
}
