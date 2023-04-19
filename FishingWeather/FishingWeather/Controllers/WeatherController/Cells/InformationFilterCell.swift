//
//  InformationFilterCell.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit
import SDWebImage

class InformationFilterCell: UICollectionViewCell {
    
    static var id = String(describing: InformationFilterCell.self)
    
    private var weatherData: ListWeatherModel?
    
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 46, height: 100)
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        view.layer.cornerRadius = view.frame.height / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageViewWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
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
        self.contentView.addSubview(conteinerView)
        conteinerView.addSubviews(
            timeLabel,
            imageViewWeather,
            temperatureLabel
            )
        
        layoutContainerView()
        layoutImageViewWeather()
        layoutTemperatureLabel()
    }
    
    private func layoutContainerView() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: self.topAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    private func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -12),
            timeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 14)
        ])
    }
    
    private func layoutImageViewWeather() {
        NSLayoutConstraint.activate([
            imageViewWeather.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            imageViewWeather.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -11),
            imageViewWeather.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 11),
        ])
    }
    
    private func layoutTemperatureLabel() {
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: imageViewWeather.bottomAnchor, constant: 16),
            temperatureLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 12.5),
            temperatureLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 13.5),
            temperatureLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -11)
        ])
    }
    
    func set(weatherData: ListWeatherModel) {
        self.weatherData = weatherData
        let url = URL(string: "https://openweathermap.org/img/wn/\(weatherData.weatherIcon)@2x.png")
        imageViewWeather.sd_setImage(with: url)

    }
    
    private func setupData() {
        

    }
    
}
