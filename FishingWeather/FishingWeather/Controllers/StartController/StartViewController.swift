//
//  StartViewController.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import UIKit

class StartViewController: UIViewController {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "StartImageController")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.addTarget(
            self,
            action: #selector(skipAction),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var indicatorStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let weather = "Fishing Weather"
        let forecast = "Forecast"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 0.80
        
        let weatherAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        let forecastAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 33, weight: .regular),
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        
        let joinText = [weather, forecast].joined(separator: " ")
        let attributedString = NSMutableAttributedString(string: joinText)
        let rangeWeather = attributedString.mutableString.range(of: weather)
        let rangeForecast = attributedString.mutableString.range(of: forecast)
        
        
        attributedString.addAttributes(weatherAttributes, range: rangeWeather)
        attributedString.addAttributes(forecastAttributes, range: rangeForecast)
        
        label.attributedText = attributedString
        
        return label
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutElements()
        imageView.alpha = 0
        titleLabel.alpha = 0
        animateShow()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setViewColor()
    }
    
    @objc private func skipAction() {
        
    }
    
    private func setViewColor() {
        let topColor = UIColor(red: 242/255.0, green: 244/255.0, blue: 247/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 188/255.0, green: 200/255.0, blue: 214/255.0, alpha: 1.0).cgColor
        mainView.applyGradient(colors: [topColor, bottomColor])
    }
    
    private func layoutElements() {
        view.addSubview(mainView)
        mainView.addSubviews(imageView, titleLabel, descriptionView)
        
        layoutMainView()
        layoutImageView()
        layoutTitleLabel()
        layoutDescriptionView()
    }
    
    private func layoutMainView() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func layoutImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 203),
            imageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -86),
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 74),
            imageView.heightAnchor.constraint(equalToConstant: 147),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 49),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 62),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -62),

        ])
    }
    
    private func layoutDescriptionView() {
        NSLayoutConstraint.activate([
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 96),
            descriptionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: -66),
            descriptionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 67)
        ])
    }
    
    private func animateShow() {
        UIView.animate(withDuration: 1, delay: 1) {
            self.imageView.alpha = 1
            self.titleLabel.alpha = 1
        } completion: { isFinished in
            guard isFinished else { return}
            UIView.animate(withDuration: 1, delay: 1) {
                self.imageView.alpha = 0
                self.titleLabel.alpha = 0
                
            } completion: { isFinished in
                guard isFinished else { return}
                let infoVC = InformationViewController()
                self.navigationController?.pushViewController(infoVC, animated: true)
            }
        }
    }
    
    private func animateDescriptionView() {
        heightConstraint = descriptionView.heightAnchor.constraint(equalToConstant: 493)
        heightConstraint?.isActive = true

        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        } completion: { isFinish in
            guard isFinish else {return}
            
            UIView.animate(withDuration: 0.7) {
                self.descriptionView.layer.cornerRadius = self.descriptionView.frame.height / 2
            }
        }
    }
    
}
