//
//  CameraScanButtonView.swift
//  croins
//
//  Created by Daniella Onishi on 24/11/21.
//

import Foundation
import UIKit
import Vision
import VisionKit


class CameraScanButtonView: UIView {
    
    var hostingViewController: UIViewController?
    weak var receiptProcessorDelegate: VisionReceiptProcessorDelegate?
    var currentReceiptProcessor: VisionReceiptProcessor?
    
    let cameraEntryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.backgroundColor = .black
        button.clipsToBounds = true
        button.layer.borderColor = CGColor(gray: 2, alpha: 1)
        button.layer.borderWidth = 2
        return button
    }()
        
    let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "Camera"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
   
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        
        cameraEntryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonOnPress(sender:))))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cameraEntryButton.layer.cornerRadius = cameraEntryButton.frame.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(cameraEntryButton)
        addSubview(buttonLabel)
    }
    
    func setupConstraints() {
        cameraEntryButton.layout {
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 0)
            $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
        }

        buttonLabel.layout {
            $0.centerXAnchor.constraint(equalTo: cameraEntryButton.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: cameraEntryButton.widthAnchor)
            $0.topAnchor.constraint(equalTo: cameraEntryButton.bottomAnchor, constant: 8)
        }
    }
    
    @objc func buttonOnPress(sender: UIButton!) {
        currentReceiptProcessor = VisionReceiptProcessor()
        currentReceiptProcessor?.delegate = receiptProcessorDelegate
        
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = currentReceiptProcessor
        hostingViewController?.present(documentCameraViewController, animated: true)
    }
    
}
