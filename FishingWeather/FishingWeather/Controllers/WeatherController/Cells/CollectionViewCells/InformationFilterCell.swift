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
        
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 9)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var imageViewWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "cloud")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 8)
        label.text = "Temp"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
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
        layoutTitleLabel()
        layoutImageViewWeather()
        layoutTemperatureLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func layoutContainerView() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
    }
    
    private func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 11),
            timeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -12),
            timeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 14)
        ])
    }
    
    private func layoutImageViewWeather() {
        NSLayoutConstraint.activate([
//            imageViewWeather.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            imageViewWeather.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -11),
            imageViewWeather.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 11),
            imageViewWeather.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor),
            imageViewWeather.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor),
            imageViewWeather.heightAnchor.constraint(equalToConstant: 15.43),
            imageViewWeather.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func layoutTemperatureLabel() {
        NSLayoutConstraint.activate([
//            temperatureLabel.topAnchor.constraint(equalTo: imageViewWeather.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 12.5),
            temperatureLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -13.5),
            temperatureLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -11)
        ])
    }
    
    func set(weatherHourData: HourForecastModel) {
        guard let url = weatherHourData.condition?.icon else { return }
        guard let time = weatherHourData.timeEpoch else { return }
        guard let temp = weatherHourData.tempC else { return }
        self.conteinerView.layer.borderWidth = self.isSelected ? 2:0
        self.conteinerView.layer.borderColor = UIColor.white.cgColor
        
        timeLabel.text = dateFormater(time: time)
        temperatureLabel.text = "\(temp), °C"

        imageViewWeather.sd_setImage(with: URL(string: String("https:" + url)))
    }
    
    private func dateFormater(time: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.timeStyle = .short
        let localDate = utcDateFormatter.string(from: date as Date)
        return localDate
    }
}
