//
//  VisionReceiptProcessorDelegate.swift
//  croins
//
//  Created by Daniella Onishi on 23/11/21.
//

import UIKit
import Vision

protocol VisionReceiptProcessorDelegate: AnyObject {
    func didFinishProcessingImage(recognizedText: [VNRecognizedTextObservation])
}
