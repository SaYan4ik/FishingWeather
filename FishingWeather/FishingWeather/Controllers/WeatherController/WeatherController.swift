//
//  WeatherController.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import UIKit
import CoreLocation
import Combine

class WeatherController: UIViewController {

    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 17)
        label.text = "Location"
        return label
    }()
    
    lazy var rightTopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_more_vert_24px"), for: .normal)
        return button
    }()
    
    lazy var leftTopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_menu_24px"), for: .normal)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    private var locationManager = CLLocationManager()
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: WeatherViewModel
    private var weatherModel: FiveDayWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutElements()
        bindViewModel()
        setupMyLocationCoord()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setViewColor()
    }
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewColor() {
        let topColor = UIColor(red: 72/255.0, green: 75/255.0, blue: 91/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 44/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0).cgColor
        mainView.applyGradient(colors: [topColor, bottomColor])
    }
    
    private func layoutElements() {
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubviews(leftTopButton, rightTopButton)
        
        layoutMainView()
        layoutTitleLabel()
        layoutTopButtons()
    }
    
    private func layoutMainView() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func layoutTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leftTopButton.leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: rightTopButton.trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func layoutTopButtons() {
        NSLayoutConstraint.activate([
            leftTopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            leftTopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leftTopButton.heightAnchor.constraint(equalToConstant: 24),
            leftTopButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            rightTopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            rightTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rightTopButton.heightAnchor.constraint(equalToConstant: 24),
            rightTopButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    private func setupMyLocationCoord() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   
        
    private func bindViewModel() {
        viewModel.$weatherList.sink { [weak self] weatherList in
            guard let self else { return }
            self.weatherModel = weatherList
        }.store(in: &cancellables)
        
        viewModel.$navTitle.sink { [weak self] text in
            guard let self else { return }
            self.titleLabel.text = text
            print(text)
        }.store(in: &cancellables)
    }
    
}


extension WeatherController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        viewModel.fetchWeather(lat: locValue.latitude, lon: locValue.longitude)
    }
}
