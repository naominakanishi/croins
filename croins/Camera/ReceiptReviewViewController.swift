//
//  ReceiptReviewViewController.swift
//  croins
//
//  Created by Daniella Onishi on 24/11/21.
//

import UIKit
import Vision

class ReceiptReviewViewController: UIViewController {
    
    static let tableCellIdentifier = "receiptContentCell"
    // The information to fetch from a scanned receipt.
    struct ReceiptContents {
        var items = [String]()
    }
    var contents = ReceiptContents()
    
    
    private lazy var receiptPlaceholder: UIView = {
        let placeholder = UIView()
        placeholder.backgroundColor = .white
        placeholder.layer.cornerRadius = 20
        return placeholder
    }()
    
    
    private lazy var receiptIcon: UIImage? = {
        let receiptIcon = UIImage(named: "")
        return receiptIcon
    }()
    
    private lazy var receiptTitle: UILabel = {
        let receiptTitle = UILabel()
        receiptTitle.text = "Receipt"
        receiptTitle.font = .systemFont(ofSize: 14)
        receiptTitle.textAlignment = .left
        return receiptTitle
    }()
    
    private lazy var receiptTableView: UITableView = {
        let receiptTableView = UITableView()
        receiptTableView.backgroundColor = .white
        return receiptTableView
     
    }()
}

// MARK: UITableViewDataSource
extension ReceiptReviewViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.items.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = contents.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptContentsViewController.tableCellIdentifier, for: indexPath)
        cell.textLabel?.text = field
        cell.detailTextLabel?.text = field
        print("\(field)")
        return cell
    }
}

// MARK: RecognizedTextDataSource
extension ReceiptReviewViewController: VisionReceiptProcessorDelegate {
    func didFinishProcessingImage(recognizedText: [VNRecognizedTextObservation]) {
//        // Create a full transcript to run analysis on.
//        var currLabel: String?
//        let maximumCandidates = 1
//        for observation in recognizedText {
//            guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
//            let isLarge = (observation.boundingBox.height > ReceiptContentsViewController.textHeightThreshold)
//            var text = candidate.string
//            // The value might be preceded by a qualifier (e.g A small '3x' preceding 'Additional shot'.)
//            var valueQualifier: VNRecognizedTextObservation?
//
//            if isLarge {
//                if let label = currLabel {
//                    if let qualifier = valueQualifier {
//                        if abs(qualifier.boundingBox.minY - observation.boundingBox.minY) < 0.01 {
//                            // The qualifier's baseline is within 1% of the current observation's baseline, it must belong to the current value.
//                            let qualifierCandidate = qualifier.topCandidates(1)[0]
//                            text = qualifierCandidate.string + " " + text
//                        }
//                        valueQualifier = nil
//                    }
//                    contents.items.append((label, text))
//                    currLabel = nil
//                } else if contents.name == nil && observation.boundingBox.minX < 0.5 && text.count >= 2 {
//                    // Name is located on the top-left of the receipt.
//                    contents.name = text
//                }
//            } else {
//                if text.starts(with: "#") {
//                    // Order number is the only thing that starts with #.
//                    contents.items.append(("Order", text))
//                } else if currLabel == nil {
//                    currLabel = text
//                } else {
//                    do {
//                        // Create an NSDataDetector to detect whether there is a date in the string.
//                        let types: NSTextCheckingResult.CheckingType = [.date]
//                        let detector = try NSDataDetector(types: types.rawValue)
//                        let matches = detector.matches(in: text, options: .init(), range: NSRange(location: 0, length: text.count))
//                        if !matches.isEmpty {
//                            contents.items.append(("Date", text))
//                        } else {
//                            // This observation is potentially a qualifier.
//                            valueQualifier = observation
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//        tableView.reloadData()
//        navigationItem.title = contents.name != nil ? contents.name : "Scanned Receipt"
    }
}


