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
        label.textAlignment = .center
        
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .none
        format.dateStyle = .long
        label.text = "\(format.string(from: mytime))"

        
        label.textColor = UIColor(red: 0.608, green: 0.618, blue: 0.678, alpha: 1)
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Impact", size: 40.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var foolInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray4
        label.textAlignment = .center
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
        layoutDescriptionLabel()
        layoutFoolInfoLabel()
    }
    
    private func layoutСontentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func layoutLabelView() {
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 11),
            labelView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -122),
            labelView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 122),
            labelView.heightAnchor.constraint(equalToConstant: 28)
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
            weatherImageView.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: 7),
            weatherImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            weatherImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherImageView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    private func layoutWeatherTemperetureLabel() {
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -48),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.weatherImageView.trailingAnchor, constant: 77),
            temperatureLabel.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: 24)
        ])
    }
    
    private func layoutDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionWeatherLabel.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor, constant: 7),
            descriptionWeatherLabel.centerXAnchor.constraint(equalTo: self.temperatureLabel.centerXAnchor)
        ])
    }
    
    private func layoutFoolInfoLabel() {
        NSLayoutConstraint.activate([
            foolInformationLabel.topAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor, constant: 15),
            foolInformationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -46),
            foolInformationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 47)
        ])
    }
    
}

