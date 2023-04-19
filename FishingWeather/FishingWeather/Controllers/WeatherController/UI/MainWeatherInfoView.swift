//
//  MainWeatherInfoView.swift
//  FishingWeather
//
//  Created by Александр Янчик on 19.04.23.
//

import UIKit

class MainWeatherInfoView: UIView {
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        
        return label
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var humiditiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .regular)
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
        contentView.addSubviews(
            rainLabel,
            windLabel,
            humiditiLabel,
            pressureLabel
        )
        
        layoutСontentView()
        layoutLabels()
        
    }
    
    private func layoutСontentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func layoutLabels() {
        NSLayoutConstraint.activate([
            rainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            rainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            rainLabel.bottomAnchor.constraint(equalTo: windLabel.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            windLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            windLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27)
        ])
        
        NSLayoutConstraint.activate([
            humiditiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.5),
            humiditiLabel.leadingAnchor.constraint(equalTo: rainLabel.trailingAnchor, constant: 80),
            humiditiLabel.bottomAnchor.constraint(equalTo: pressureLabel.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            pressureLabel.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 100),
            pressureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27)
        ])
        
    }
}
