//
//  InformationViewController.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit

class InformationViewController: UIViewController {
    lazy var mainView: UIView = {
        let view = UIView()
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
    
    lazy var descriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bitmap")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var indicatorStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.backgroundColor = UIColor(red: 72/255, green: 75/255, blue: 91/255, alpha: 1)
        button.addTarget(
            self,
            action: #selector(nextDescription),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var circleView: GradientCircularProgressBar = {
        let view = GradientCircularProgressBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Detailed Hourly Forecast"
        return label
    }()
    
    lazy var bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemGray2
        label.text = "Get in - depth weather information."
        return label
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    private var currentSelectedIndex = 0 {
        didSet {
            updateSelectedCardIndicator()
        }
    }
    
    private var progress: CGFloat = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setViewColor()
        self.nextButton.roundCorners(cornerRadius: nextButton.frame.height)
        self.descriptionView.roundTopCorners(cornerRadius: 370)
    }
    
    private func layoutElements() {
        self.view.addSubview(mainView)
        self.mainView.addSubviews(
            descriptionImageView,
            skipButton,
            indicatorStack,
            descriptionView,
            circleView,
            nextButton
        )
        self.descriptionView.addSubviews(
            topDescriptionLabel,
            bottomDescriptionLabel
        )
        
        layoutMainView()
        layoutSkipButton()
        layoutDescriptionView()
        layoutImageView()
        layoutIndicatorStack()
        showIndicator()
        layoutNextButton()
        layoutCircleView()
        layoutDescriptionLabels()
        
        
    }
    
    private func layoutMainView() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func layoutSkipButton() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32)
        ])
    }
    
    private func layoutImageView() {
        NSLayoutConstraint.activate([
            descriptionImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            descriptionImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            descriptionImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),

            descriptionImageView.heightAnchor.constraint(equalToConstant: 300),
            descriptionImageView.widthAnchor.constraint(equalToConstant: 300),
            descriptionImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func layoutDescriptionView() {
        NSLayoutConstraint.activate([
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            descriptionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            descriptionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            descriptionView.heightAnchor.constraint(equalToConstant: 397),
        ])
    }
    
    private func layoutIndicatorStack() {
        NSLayoutConstraint.activate([
            indicatorStack.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 5),
            indicatorStack.centerXAnchor.constraint(equalTo: descriptionView.centerXAnchor)
        ])
    }
    
    private func layoutNextButton() {
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 53.33),
            nextButton.widthAnchor.constraint(equalToConstant: 53.33)
        ])
    }
    
    private func layoutCircleView() {
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: self.nextButton.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: self.nextButton.centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 80),
            circleView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func layoutDescriptionLabels() {
        NSLayoutConstraint.activate([
            bottomDescriptionLabel.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -20),
            bottomDescriptionLabel.leadingAnchor.constraint(equalTo: self.descriptionView.leadingAnchor, constant: 16),
            bottomDescriptionLabel.trailingAnchor.constraint(equalTo: self.descriptionView.trailingAnchor, constant: -16),

        ])
        
        NSLayoutConstraint.activate([
            topDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomDescriptionLabel.topAnchor, constant: -20),
            topDescriptionLabel.leadingAnchor.constraint(equalTo: self.descriptionView.leadingAnchor, constant: 16),
            topDescriptionLabel.trailingAnchor.constraint(equalTo: self.descriptionView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setViewColor() {
        let topColor = UIColor(red: 72/255.0, green: 75/255.0, blue: 91/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 44/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0).cgColor
        
        mainView.applyGradient(colors: [topColor, bottomColor])
    }
    
    private func showIndicator() {
        for index in 0...3 {
            let dot = UIImageView(image: UIImage(systemName: "circle.fill"))
            dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
            dot.image = dot.image!.withRenderingMode(.alwaysTemplate)
            dot.tintColor = UIColor.lightGray
            dot.tag = index + 1
            
            if index == currentSelectedIndex {
                dot.tintColor = UIColor.darkGray
            }
            
            indicatorStack.addArrangedSubview(dot)
        }
    }
    
    private func updateSelectedCardIndicator() {
        for index in 0...3 {
            let selectedIndicator: UIImageView? = indicatorStack.viewWithTag(index + 1) as? UIImageView
            selectedIndicator?.tintColor = index == currentSelectedIndex ? UIColor.darkGray: UIColor.lightGray
        }
    }
    
    @objc private func skipAction() {
        
    }
    
    @objc private func nextDescription() {
        progress += 0.25
        circleView.progress = progress
        
        switch progress {
            case 0.25:
                descriptionImageView.image = UIImage(named: "Bitmap")
                currentSelectedIndex = 0
                topDescriptionLabel.text = "Detailed Hourly Forecast"
                bottomDescriptionLabel.text = "Get in - depth weather information."
            case 0.50:
                descriptionImageView.image = UIImage(named: "Bitmap 1")
                currentSelectedIndex = 1
                topDescriptionLabel.text = "Real-Time Weather Map"
                bottomDescriptionLabel.text = "Watch the progress of the precipitation to stay informed"

            case 0.75:
                descriptionImageView.image = UIImage(named: "Bitmap 2")
                currentSelectedIndex = 2
                topDescriptionLabel.text = "Weather Around the World"
                bottomDescriptionLabel.text = "Add any location you want and swipe easily to chnage."

            case 1.00:
                descriptionImageView.image = UIImage(named: "Bitmap 3")
                currentSelectedIndex = 3
                topDescriptionLabel.text = "Detailed Hourly Forecast"
                bottomDescriptionLabel.text = "Get in - depth weather information."

            case 1.25:
                Environment.sceneDelegare?.setWeatherController()
            default:
                break
        }
    }
    
}
