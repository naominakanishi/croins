//
//  CameraEntryViewController.swift
//  croins
//
//  Created by Daniella Onishi on 23/11/21.
//

import UIKit
import VisionKit
import Vision

class CameraEntryViewController: UIViewController {
    
    let scanButton: CameraScanButtonView = {
        let view = CameraScanButtonView()
        return view
    }()

    override func loadView() {
        super.loadView()
        addSubviews()
        scanButton.hostingViewController = self
        scanButton.receiptProcessorDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(scanButton)
    }
    
    func setupConstraints() {
        scanButton.layout {
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.widthAnchor.constraint(equalToConstant: 170)
            $0.heightAnchor.constraint(equalToConstant: 200)
        }
    }
}

extension CameraEntryViewController: VisionReceiptProcessorDelegate {
    func didFinishProcessingImage(recognizedText: [VNRecognizedTextObservation]) {
        print("recognized text")
        print(recognizedText)
        
        let vc = ReceiptContentsViewController()
        vc.didFinishProcessingImage(recognizedText: recognizedText)
        present(vc, animated: true, completion: nil)
        // Cria uma vc pra mostrar o resultado (a famosa table view que voce fala toda hora)
        // Manda pra essa vc o recognizedText
    }
}
