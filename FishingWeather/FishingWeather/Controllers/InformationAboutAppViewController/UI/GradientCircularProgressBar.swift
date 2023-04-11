//
//  GradientCircularProgressBar.swift
//  FishingWeather
//
//  Created by Александр Янчик on 8.04.23.
//

import UIKit

class GradientCircularProgressBar: UIView {
    
    private var color: UIColor = .gray
    private var gradientColor: UIColor = .white
    
    private var ringWidth: CGFloat = 5
    
    var progress: CGFloat = 0.25 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
//        createAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        self.layer.mask = backgroundMask
        
        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        
        self.layer.addSublayer(gradientLayer)
        self.layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
        
        gradientLayer.mask = progressLayer
        gradientLayer.locations = [0.35, 0.5, 0.65]
    }
    
    private func createAnimation() {
        let startPointAnimation = CAKeyframeAnimation(keyPath: "startPoint")
        startPointAnimation.values = [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1)]
        
        startPointAnimation.repeatCount = Float.infinity
        startPointAnimation.duration = 1
        
        let endPointAnimation = CAKeyframeAnimation(keyPath: "endPoint")
        endPointAnimation.values = [CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1), CGPoint.zero]
        
        endPointAnimation.repeatCount = Float.infinity
        endPointAnimation.duration = 1
        
        gradientLayer.add(startPointAnimation, forKey: "startPointAnimation")
        gradientLayer.add(endPointAnimation, forKey: "endPointAnimation")
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.frame = rect
        gradientLayer.colors =
        [
            UIColor(red: 255/255, green: 79/255, blue: 128/255, alpha: 1).cgColor,
            UIColor(red: 194/255, green: 58/255, blue: 172/255, alpha: 1).cgColor,
            UIColor(red: 255/255, green: 79/255, blue: 128/255, alpha: 1).cgColor
        ]
    }
}
