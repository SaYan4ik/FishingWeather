//
//  View+Extension.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit

extension UIView {
    enum Direction: Int {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func applyGradient(colors: [CGColor]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
        
        let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer ?? CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.shouldRasterize = true
        
        switch direction {
            case .topToBottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                
            case .bottomToTop:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                
            case .leftToRight:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                
            case .rightToLeft:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        guard gradientLayer.superlayer != self else {
            return
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func changeGradienWithAnimation() {
        let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer ?? CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 242/255.0, green: 244/255.0, blue: 247/255.0, alpha: 1.0).cgColor,
            UIColor(red: 188/255.0, green: 200/255.0, blue: 214/255.0, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 1.0
        gradientChangeAnimation.toValue = [
            UIColor(red: 72/255.0, green: 75/255.0, blue: 91/255.0, alpha: 1.0).cgColor,
            UIColor(red: 44/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0).cgColor
            ]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")

    }
    
    func roundTopCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius) / 2
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
    }
    
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius) / 2
        self.clipsToBounds = true
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
