//
//  VisionReceiptProcessor.swift
//  croins
//
//  Created by Daniella Onishi on 23/11/21.
//

import Foundation
import Vision
import VisionKit

class VisionReceiptProcessor: NSObject {
    
    weak var delegate: VisionReceiptProcessorDelegate? = nil
    var textRecognitionRequest = VNRecognizeTextRequest()
    
    override init() {
        super.init()
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            guard let delegate = self.delegate else {
                print("delegate is not set")
                return
            }
            if let results = request.results, !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    DispatchQueue.main.async {
                        delegate.didFinishProcessingImage(recognizedText: requestResults)
                    }
                }
            }
        })
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    }
    
    func processImage(image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Failed to get cgimage from input image")
            return
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
}

extension VisionReceiptProcessor: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        controller.dismiss(animated: true) {
            DispatchQueue.global(qos: .userInitiated).async {
                for pageNumber in 0 ..< scan.pageCount {
                    let image = scan.imageOfPage(at: pageNumber)
                    self.processImage(image: image)
                }
            }
        }
    }
}
