//
//  ProgressView.swift
//  croins
//
//  Created by Naomi Nakanishi on 16/11/21.
//

import Foundation
import UIKit

class ProgressView: UIView {

    struct Setup {
        let backgroundColor: UIColor
        let tintColor: UIColor
        let lineWidth: CGFloat = 15
    }
    
    struct Progress {
        /// Valor total do grafico . Ex 500
        let total: Double
        /// Progresso atual. Ex: 250
        let progress: Double
    }
    
    private let setup: Setup
    private var progress: Progress?
    
    init(setup: Setup) {
        self.setup = setup
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(progress: Progress) {
        self.progress = progress
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        layer.addSublayer(backgroundLayerFactory)
        if let progressLayerFactory = progressLayerFactory {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            progressLayerFactory.add(animation, forKey: "strokeAnimation")
            layer.addSublayer(progressLayerFactory)
        }
    }
    
    private var progressLayerFactory: CALayer? {
        guard let progress = progress else {
            return nil
        }
        let path = UIBezierPath(
            arcCenter: .init(x: bounds.midX, y: bounds.midY),
            radius: frame.width / 2 - setup.lineWidth / 2,
            startAngle: -.pi / 2,
            endAngle: (2 * .pi * progress.progress / progress.total) - .pi / 2,
            clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = setup.lineWidth
        layer.lineCap = .round
        layer.strokeColor = setup.tintColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }
    
    private var backgroundLayerFactory: CALayer {
        let path = UIBezierPath(
            arcCenter: .init(x: bounds.midX, y: bounds.midY),
            radius: frame.width / 2 - setup.lineWidth / 2,
            startAngle: 0,
            endAngle: 2 * .pi,
            clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = setup.lineWidth
        layer.lineCap = .round
        layer.strokeColor = setup.backgroundColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }
}
