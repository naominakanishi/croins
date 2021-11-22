import UIKit

final class PizzaChartView: UIView {
    
    private var slices: [Slice] = []
    
    struct Slice {
        let percentage: Double
        let color: UIColor
    }
    
    func configure(slices: [Slice]) {
        self.slices = slices
        backgroundColor = .clear
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        var startingAngle: CGFloat = 0
        let center: CGPoint = .init(x: rect.midX, y: rect.midY)
        
        for slice in slices {
            let deltaTheta: CGFloat = 2 * .pi * slice.percentage
            let endingAngle = deltaTheta + startingAngle
            let path = UIBezierPath (
                arcCenter: center,
                radius: rect.width / 2,
                startAngle: startingAngle,
                endAngle: endingAngle,
                clockwise: true)
            
            path.addLine(to: center)
            path.close()
            slice.color.setFill()
            path.fill()
            startingAngle = endingAngle
        }
    }
}
