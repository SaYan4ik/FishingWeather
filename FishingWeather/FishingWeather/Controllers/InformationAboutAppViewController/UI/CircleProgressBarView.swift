//
//  CircleProgressBarView.swift
//  FishingWeather
//
//  Created by Александр Янчик on 6.04.23.
//

import UIKit

class CircleProgressBarView: UIView {
    
    var progressLyr = CAShapeLayer()
    var trackLyr = CAShapeLayer()

    
    private var progressClr = UIColor.white {
        didSet {
            progressLyr.strokeColor = progressClr.cgColor
        }
    }
    private var trackClr = UIColor.white {
        didSet {
            trackLyr.strokeColor = trackClr.cgColor
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCircularPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
            radius: (self.frame.size.width - 1.5)/2,
            startAngle: CGFloat(-0.5 * .pi),
            endAngle: CGFloat(1.5 * .pi),
            clockwise: true
        )
        
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = trackClr.cgColor
        trackLyr.lineWidth = 3.0
        trackLyr.strokeEnd = 1.0
        layer.addSublayer(trackLyr)
        
        progressLyr.path = circlePath.cgPath
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 3.0
        progressLyr.strokeEnd = 0.0
        layer.addSublayer(progressLyr)
        
//        let grad = CAGradientLayer()
//
//        grad.colors = [
//            UIColor(red: 255/255, green: 79/255, blue: 128/255, alpha: 1).cgColor,
//            UIColor(red: 194/255, green: 58/255, blue: 172/255, alpha: 1).cgColor
//        ]
//
//        progressLyr.path = circlePath.cgPath
//        grad.frame = frame
//        grad.mask = progressLyr
//        self.layer.addSublayer(grad)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLyr.strokeEnd
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLyr.strokeEnd = CGFloat(value)
        progressLyr.add(animation, forKey: "animateprogress")
    }
    
}
