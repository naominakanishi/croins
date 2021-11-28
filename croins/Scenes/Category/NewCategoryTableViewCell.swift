//
//  NewCategoryTableViewCell.swift
//  croins
//
//  Created by Daniella Onishi on 28/11/21.
//

import UIKit

class NewCategoryTableViewCell: UITableViewCell {
    
    let categoryViewModel = CategoryViewModel()
    
    private lazy var transactionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "circle")
        view.tintColor = .green
        return view
    }()
    
    private lazy var transactionLabel: UILabel = {
        let view = UILabel()
        view.text = "Nova Categoria"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var newCategoryEntryTextField: UITextField = {
        let view = TextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "Nome da categoria",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    private lazy var targetEntryTextField: NumberFormattedTextField = {
        let view = NumberFormattedTextField(inset: 15)
        view.backgroundColor = .white
        view.attributedPlaceholder = .init(string: "Gasto máximo",
                                           attributes: [
                                            .font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor(ciColor: .black)])
        view.font = UIFont.systemFont(ofSize: 14)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dismissKeyboard), for: .editingDidEndOnExit)
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func addSubviews() {
        contentView.addSubview(transactionImage)
        contentView.addSubview(transactionLabel)
        contentView.addSubview(newCategoryEntryTextField)
        contentView.addSubview(targetEntryTextField)
        contentView.addSubview(saveButton)
    }
    
    func setupConstraints() {
        transactionImage.layout {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            $0.widthAnchor.constraint(equalToConstant: 24)
            $0.heightAnchor.constraint(equalTo: transactionImage.widthAnchor)
        }
        
        transactionLabel.layout {
            $0.leadingAnchor.constraint(equalTo: transactionImage.trailingAnchor, constant: 10)
            $0.bottomAnchor.constraint(equalTo: newCategoryEntryTextField.topAnchor)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        }
        
        newCategoryEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor, constant: 25)
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
        
        targetEntryTextField.layout {
            $0.topAnchor.constraint(equalTo: newCategoryEntryTextField.bottomAnchor, constant: 25)
            $0.heightAnchor.constraint(equalTo: newCategoryEntryTextField.heightAnchor)
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
        
        saveButton.layout {
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            $0.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
            $0.heightAnchor.constraint(equalToConstant: 40)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        }
    }
}
    
    @objc
    private extension NewCategoryTableViewCell {
        
        func dismissKeyboard() {
            contentView.endEditing(true)
        }
        
        func setupKeyboardDismissGesture() {
            contentView.addGestureRecognizer(UITapGestureRecognizer(
                target: self, action: #selector(dismissKeyboard)
            ))
        }
        
        func removeKeyboardDismissGesture() {
            contentView.gestureRecognizers?
                .filter { $0 is UITapGestureRecognizer }
                .forEach(contentView.removeGestureRecognizer)
        }
        
        func saveButtonTap() {
            guard let title = newCategoryEntryTextField.text
            else { return }
            categoryViewModel.addNewCategory(
                Category(
                    title: title,
                    target: targetEntryTextField.amount
                ))
        }
    }

