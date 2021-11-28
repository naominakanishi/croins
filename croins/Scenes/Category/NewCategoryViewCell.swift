//
//  NewCategoryViewCell.swift
//  croins
//
//  Created by Daniella Onishi on 27/11/21.
//

import UIKit

class NewCategoryViewCell: UICollectionViewCell {
    
    var newCategoryBorder: CAShapeLayer!
    var label = UILabel()
    var plusIcon = UIImageView()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Nova Categoria"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        //setupBorder()
        //setupPlusIcon()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView
            .addSubview(newCellView)
        contentView
            .addSubview(newCellLabel)
    }
    
//    override func layoutSubviews() {
//       // super.layoutSubviews()
//        contentView.layoutSubviews()
//        _ = contentView.layer.sublayers?.filter({ $0 as? CAShapeLayer != nil }).forEach({ $0.removeFromSuperlayer() })
//        setupBorder()
//    }
    
    private lazy var newCellView: UIView = {
        let newCellView = UIView()
        newCellView.backgroundColor = .red
        return newCellView
    }()
    
    private lazy var newCellLabel: UILabel = {
        let newCellLabel = UILabel()
        newCellLabel.text = "sua irma"
        newCellLabel.font = .systemFont(ofSize: 7)
        return newCellLabel
    }()
    
    func setupBorder() {
        newCategoryBorder = CAShapeLayer()
        newCategoryBorder.lineWidth = 1
        newCategoryBorder.strokeColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        newCategoryBorder.lineDashPattern = [10, 8] as [NSNumber]
        newCategoryBorder.frame = bounds
        newCategoryBorder.fillColor = nil
        newCategoryBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 100).cgPath
        self.contentView.layer.addSublayer(newCategoryBorder)
    }
    
    func setupPlusIcon() {
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(plusIcon)
        plusIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        plusIcon.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height * 0.5 - 20).isActive = true
        plusIcon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        plusIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        plusIcon.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        plusIcon.tintColor = .white
    }
    
    func setupConstraints() {
        newCellView.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }
        
        newCellLabel.layout {
            $0.topAnchor.constraint(equalTo: newCellView.bottomAnchor, constant: 10)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            $0.leadingAnchor.constraint(equalTo: newCellView.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: newCellView.trailingAnchor)
        }
            }
}
