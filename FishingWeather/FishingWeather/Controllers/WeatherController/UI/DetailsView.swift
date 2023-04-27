//
//  DetailsView.swift
//  FishingWeather
//
//  Created by Александр Янчик on 27.04.23.
//

import UIKit

class DetailsView: UIView {
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 100
        return stack
    }()
    
    lazy var nameLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    lazy var paramsLabelStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private var labelsName: [LabelName] = LabelName.allCases
    private var paramsForecast: [String] = []
    private var hourForecast: HourForecastModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        self.addSubview(conteinerView)
        self.conteinerView.addSubviews(nameLabel, stackContainer)
        self.stackContainer.addArrangedSubview(nameLabelStack)
        self.stackContainer.addArrangedSubview(paramsLabelStack)
        
        layoutContainerView()
        layoutNameLabel()
        layoutWeatherImageView()
        layoutStackViewContainer()
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
            conteinerView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 36),
            conteinerView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -26),
            conteinerView.heightAnchor.constraint(equalToConstant: 154)
        ])
    }
    
    private func createNameLabels(paramsNameLabel: String) {
        let labelName = UILabel()
        labelName.text = paramsNameLabel
        self.nameLabelStack.addArrangedSubview(labelName)
    }
    
    private func cerateParamsLabel(param: String) {
        let paramLabel = UILabel()
        paramLabel.text = param
        self.paramsLabelStack.addArrangedSubview(paramLabel)
    }
    
    func set(forecast: HourForecastModel) {
        self.hourForecast = forecast
        guard let feelsLike = forecast.feelslikeC,
              let humidity = forecast.hummidity,
              let preassure = forecast.preassureMb,
              let wind = forecast.windMph
        else { return }
        
        paramsForecast.append("\(feelsLike)")
        paramsForecast.append("\(humidity)")
        paramsForecast.append("\(preassure)")
        paramsForecast.append("\(wind)")
        
    }
    
    private func setupData() {
        labelsName.forEach { name in
            createNameLabels(paramsNameLabel: name.title)
        }
        
        paramsForecast.forEach { param in
            cerateParamsLabel(param: param)
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
