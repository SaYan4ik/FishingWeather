//
//  TodayWeatherInformationView.swift
//  FishingWeather
//
//  Created by Александр Янчик on 18.04.23.
//

import UIKit

class TodayWeatherInformationView: UIView {    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let labelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.196, green: 0.2, blue: 0.243, alpha: 1)
        view.layer.cornerRadius = 16
        return view
    }()
    
    lazy var todayWeatherTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(red: 0.608, green: 0.618, blue: 0.678, alpha: 1)
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 48)
        let firstColor = UIColor(red: 162/255, green: 164/255, blue: 181/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 84/255, green: 87/255, blue: 96/255, alpha: 1).cgColor
        label.applyGradient(colors: [firstColor, secondColor], locations: [0.0, 1.0], direction: .leftToRight)
        return label
    }()
    
    lazy var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var foolInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray4
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutElements() {
        self.addSubview(contentView)
        self.contentView.addSubviews(
            labelView,
            weatherImageView,
            temperatureLabel,
            descriptionWeatherLabel,
            foolInformationLabel
        )
        self.labelView.addSubview(todayWeatherTitle)
        
        layoutСontentView()
        layoutLabelView()
        layoutTodayWeatherTitle()
        layoutWeatherImage()
        layoutWeatherTemperetureLabel()
    }
    
    private func layoutСontentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    private func layoutLabelView() {
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 11),
            labelView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -122),
            labelView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 122)
        ])
    }
    
    private func layoutTodayWeatherTitle() {
        NSLayoutConstraint.activate([
            todayWeatherTitle.topAnchor.constraint(equalTo: self.labelView.topAnchor, constant: 7),
            todayWeatherTitle.bottomAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: -6),
            todayWeatherTitle.trailingAnchor.constraint(equalTo: self.labelView.trailingAnchor, constant: -16),
            todayWeatherTitle.leadingAnchor.constraint(equalTo: self.labelView.leadingAnchor, constant: 17)
        ])
    }
    
    private func layoutWeatherImage() {
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: -7),
            weatherImageView.leadingAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25),
            weatherImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherImageView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    private func layoutWeatherTemperetureLabel() {
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -48),
            temperatureLabel.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: -24)
        ])
    }
    
}

