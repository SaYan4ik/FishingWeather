//
//  WeatherController.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import UIKit
import CoreLocation
import Combine
import SDWebImage

class WeatherController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        return view
    }()
    
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: 60, height: 100)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(InformationFilterCell.self, forCellWithReuseIdentifier: InformationFilterCell.id)
        return collectionView
    }()
    
    lazy var todayInfoView: TodayWeatherInformationView = {
        let view = TodayWeatherInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dashLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainInfoWeatherView: MainWeatherInfoView = {
        let view = MainWeatherInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var detailsView: DetailsView = {
        let view = DetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var locationManager = CLLocationManager()
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: WeatherViewModel
    private var selectedIndex = IndexPath(row: 0, section: 0)
    
    private var forecastInfo: ForecastModel? {
        didSet {
            setupForecastInfo()
            self.collectionView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutElements()
        bindViewModel()
        setupMyLocationCoord()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setViewColor()
        showCurrentHourDetails()
        scrollCollectionView()
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
        self.view.applyGradient(colors: [topColor, bottomColor])
        
        self.todayInfoView.temperatureLabel.layoutIfNeeded()
        let firstColor = UIColor(red: 162/255.0, green: 164/255.0, blue: 181/255.0, alpha: 1)
        let secondColor = UIColor(red: 84/255.0, green: 87/255.0, blue: 96/255.0, alpha: 1)
        let gradient = UIImage.gradientImage(bounds: todayInfoView.temperatureLabel.bounds, colors: [firstColor, secondColor])
        todayInfoView.temperatureLabel.textColor = UIColor(patternImage: gradient)
        
        dashLine.createDottedLine(width: 1, color: UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 0.17))
        
        let detailsTopColor = UIColor(red: 35/255, green: 35/255, blue: 41/255, alpha: 1).cgColor
        let detailsBottomColor = UIColor(red: 47/255, green: 49/255, blue: 58/255, alpha: 1).cgColor
        detailsView.applyGradient(colors: [detailsTopColor, detailsBottomColor])
        
    }
    
    private func layoutElements() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubviews(titleLabel, leftTopButton, rightTopButton, todayInfoView, dashLine, mainInfoWeatherView, collectionView, detailsView)
        
        layoutScrollView()
        layoutMainView()
        layoutTitleLabel()
        layoutTopButtons()
        layoutTodayInfoWeatherView()
        layoutDashLine()
        layoutMainInfoWeatherView()
        layoutCollectionView()
        layoutDetailsView()
    }
    
    private func layoutScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func layoutMainView() {
        let heightConstraint = mainView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//            heightConstraint
            
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
    
    private func layoutTodayInfoWeatherView() {
        NSLayoutConstraint.activate([
            todayInfoView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 120),
            todayInfoView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            todayInfoView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            todayInfoView.heightAnchor.constraint(equalToConstant: 192)
        ])
    }
    
    private func layoutDashLine() {
        NSLayoutConstraint.activate([
            dashLine.topAnchor.constraint(equalTo: todayInfoView.bottomAnchor),
            dashLine.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 25),
            dashLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -25),
            dashLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func layoutMainInfoWeatherView() {
        NSLayoutConstraint.activate([
            mainInfoWeatherView.topAnchor.constraint(equalTo: dashLine.bottomAnchor, constant: 5),
            mainInfoWeatherView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainInfoWeatherView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
    }
    
    private func layoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: mainInfoWeatherView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
//            collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
    
    private func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 27),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            tableView.heightAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    private func layoutDetailsView() {
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 27),
            detailsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            detailsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            detailsView.heightAnchor.constraint(equalToConstant: 270),
            detailsView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
    
    private func setupMyLocationCoord() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
        
    private func bindViewModel() {
        viewModel.$navTitle.sink { [weak self] text in
            guard let self else { return }
            self.titleLabel.text = text
        }.store(in: &cancellables)
        
        viewModel.$forecastWeather.sink { [weak self] forecast in
            guard let self else { return }
            self.forecastInfo = forecast
        }.store(in: &cancellables)
        
        viewModel.$selectedIndex.sink { [weak self] index in
            guard let self else { return }
            self.selectedIndex = index
            self.collectionView.reloadData()
        }.store(in: &cancellables)
    }

    
    private func setupForecastInfo() {
        guard let maxTemp = forecastInfo?.forecastday?.forecastDay?.first?.day?.maxTempC,
              let minTemp = forecastInfo?.forecastday?.forecastDay?.first?.day?.minTempC,
              let feelsLike = forecastInfo?.current?.feelsLikeC,
              let currentTemp = forecastInfo?.current?.tempC,
              let hummidity = forecastInfo?.current?.humidity,
              let pressure = forecastInfo?.current?.preassureMph,
              let windSpeed = forecastInfo?.current?.windMph,
              let description = forecastInfo?.current?.condition?.text,
              let rainCnahse = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast?.first?.chanceOfRain,
              let url = forecastInfo?.current?.condition?.icon?.dropFirst(2)
        else { return }
        
        todayInfoView.weatherImageView.sd_setImage(with: URL(string: String("https://" + url)))
        todayInfoView.temperatureLabel.text = "\(currentTemp)°C"
        todayInfoView.descriptionWeatherLabel.text = description
        todayInfoView.foolInformationLabel.text = "\(maxTemp) / \(minTemp) °C | Feels like \(feelsLike) °C | Wind \(windSpeed) M/S"
        
        mainInfoWeatherView.rainLabel.text = "Rain: \(rainCnahse), % chanse"
        mainInfoWeatherView.rainLabel.addImageTest(image: UIImage(named: "rain"))
        
        mainInfoWeatherView.windLabel.text = "Wind: \(windSpeed), m/s"
        mainInfoWeatherView.windLabel.addImageTest(image: UIImage(named: "wind"))
        
        mainInfoWeatherView.humiditiLabel.text = "Humidity: \(hummidity), %"
        mainInfoWeatherView.humiditiLabel.addImageTest(image: UIImage(named: "humidity"))
        
        mainInfoWeatherView.pressureLabel.text = "Preasure: \(pressure), hPa"
        mainInfoWeatherView.pressureLabel.addImageTest(image: UIImage(named: "preasure"))
        
        guard let hourModel = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast?[selectedIndex.row] else { return }
        
        detailsView.set(forecast: hourModel)
        
    }
    
    private func scrollCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if self.forecastInfo != nil {
                self.collectionView.layoutIfNeeded()
                self.collectionView.scrollToItem(at: IndexPath(item: self.selectedIndex.row, section: 0), at: .left, animated: false)
            }
        }
    }
    
    private func showCurrentHourDetails() {
        guard let hourDate = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast else { return }
        viewModel.setupNowForecast(weatherForecast: hourDate)
    }
    
}


extension WeatherController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("\(locValue.latitude), \(locValue.longitude)")
        viewModel.getForecastWeather(latLon: "\(locValue.latitude), \(locValue.longitude)", days: 1)
        
    }
}

extension WeatherController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let numberOfCells = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast?.count else { return 0}
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InformationFilterCell.id, for: indexPath)
        guard let infoCell = cell as? InformationFilterCell else { return cell}
        guard let hourDate = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast else { return cell}
        infoCell.isSelected = selectedIndex == indexPath

        infoCell.set(weatherHourData: hourDate[indexPath.row])
        
        return infoCell
    }
}

extension WeatherController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let hourDate = forecastInfo?.forecastday?.forecastDay?.first?.hourForecast else { return }
    }
}
