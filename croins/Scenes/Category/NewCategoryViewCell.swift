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
        
        setupBorder()
        setupPlusIcon()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}
