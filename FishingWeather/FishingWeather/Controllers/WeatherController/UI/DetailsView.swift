//
//  DetailsView.swift
//  FishingWeather
//
//  Created by Александр Янчик on 27.04.23.
//

import UIKit
import SDWebImage

class DetailsView: UIView {
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    lazy var nameLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    lazy var paramsLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray5
        label.textColor = UIColor(red: 0.608, green: 0.618, blue: 0.678, alpha: 1)
        return label
    }()
    
    private var labelsName: [LabelName] = LabelName.allCases
    private var paramsForecast: [String] = [] {
        didSet {
            if paramsForecast.count == 4 {
                paramsForecast.forEach { param in
                    cerateParamsLabel(param: param)
                }
            }
        }
    }
    private var hourForecast: HourForecastModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        self.addSubview(conteinerView)
        self.conteinerView.addSubviews(nameLabel, weatherImageView, stackContainer, describeLabel)
        self.stackContainer.addArrangedSubview(nameLabelStack)
        self.stackContainer.addArrangedSubview(paramsLabelStack)
        
        layoutContainerView()
        layoutNameLabel()
        layoutWeatherImageView()
        layoutStackViewContainer()
        layoutDescribeLabel()
        setupData()
    }
    
    private func layoutContainerView() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: self.topAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    private func layoutNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
        ])
    }
    
    private func layoutWeatherImageView() {
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            weatherImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
            weatherImageView.heightAnchor.constraint(equalToConstant: 63),
            weatherImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func layoutStackViewContainer() {
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 36),
            stackContainer.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 81),
            stackContainer.heightAnchor.constraint(equalToConstant: 154),
            stackContainer.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    private func layoutDescribeLabel() {
        NSLayoutConstraint.activate([
            describeLabel.topAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: 20),
            describeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -28),
            describeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
            describeLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -30)
        ])
    }
    
    private func createNameLabels(paramsNameLabel: String) {
        let labelName = UILabel()
        labelName.font = .systemFont(ofSize: 12)
        labelName.textColor = .white
        labelName.text = paramsNameLabel
        self.nameLabelStack.addArrangedSubview(labelName)
    }
    
    private func cerateParamsLabel(param: String) {
        let paramLabel = UILabel()
        paramLabel.text = param
        paramLabel.textColor = .white
        paramLabel.font = .systemFont(ofSize: 12)
        self.paramsLabelStack.addArrangedSubview(paramLabel)
    }
    
    func set(forecast: HourForecastModel) {
        self.hourForecast = forecast
        guard let feelsLike = forecast.feelslikeC,
              let humidity = forecast.hummidity,
              let preassure = forecast.preassureMb,
              let wind = forecast.windMph,
              let condition = forecast.condition?.text,
              let windDir = forecast.windDir,
              let url = forecast.condition?.icon
        else { return }
        
        paramsForecast.append("\(feelsLike)")
        paramsForecast.append("\(humidity)")
        paramsForecast.append("\(preassure)")
        paramsForecast.append("\(wind)")
        
        self.describeLabel.text = "Now - \(condition). Wind direction \(windDir) with \(wind), Mph."
        weatherImageView.sd_setImage(with: URL(string: String("https:" + url)))

    }
    
    private func setupData() {
        labelsName.forEach { name in
            createNameLabels(paramsNameLabel: name.title)
        }
    }
    
    
}

enum LabelName: CaseIterable {
    case feelsLike
    case humidity
    case preassure
    case wind
    
    var title: String {
        switch self {
                
            case .feelsLike:
                return "Feels like, °C"
            case .humidity:
                return "Humidity, %"
            case .preassure:
                return "Pressure, Mb"
            case .wind:
                return "Wind, mph"
        }
    }
}
