//
//  WeatherViewController.swift
//  Belarus
//
//  Created by user on 13.10.22.
//

import Foundation
import UIKit
import AVFoundation

class WeatherViewController: UIViewController {
    
    let viewModel: WeatherViewModel
    
    init(viewModel:WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Тут вы маеце магчымасць азнаёміцца з прагнозам надвор'я ў цікавым для вас месцы Беларусі на бліжэйшыя гадзіны."
        label.textAlignment = .center
        label.addShadow()
        return label
    }()
    
    private var looper: AVPlayerLooper?

    private var weatherCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundVideo()
        configureUI()
        weatherCollection = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        weatherCollection.setCollectionViewLayout(generateLayout(), animated: true)
        setupCollection()
        weatherCollection.delegate = self
        weatherCollection.dataSource = self
        weatherCollection.register(WeatherCustomCell.self, forCellWithReuseIdentifier: "WeatherCell")
        Task(priority: .userInitiated) {
            await viewModel.loadWeather()
        }
    }
    
    private func configureUI() {
        view.addSubview(descriptionLabel)
        view.bringSubviewToFront(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func backgroundVideo() {
        guard let videoURL = Bundle.main.path(forResource: "clouds", ofType: "mp4") else { return }
        let url = URL(fileURLWithPath: videoURL)
        do {
            let item = AVPlayerItem(url: url)
            let player = AVQueuePlayer(items: [item])
            looper = AVPlayerLooper(player: player, templateItem: item)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            view.layer.addSublayer(playerLayer)
            player.play()
        }
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
    }
    
    private func setupCollection() {
        weatherCollection.backgroundColor = .gray
        weatherCollection.alpha = 0.7
        weatherCollection.layer.cornerRadius = 20
        weatherCollection.addShadow()
        view.addSubview(weatherCollection)
        view.bringSubviewToFront(weatherCollection)
        weatherCollection.translatesAutoresizingMaskIntoConstraints = false
        weatherCollection.heightAnchor.constraint(equalToConstant: 300).isActive = true
        weatherCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        weatherCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        weatherCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180).isActive = true
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath as IndexPath) as! WeatherCustomCell
        
        viewModel.bindWeather.bind(\.time[indexPath.row], to: cell.time, \.text) { value in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let dataDate = dateFormatter.date(from: value)
            dateFormatter.dateFormat = "HH:mm"
            let newStringDate = dateFormatter.string(from: dataDate!)
            return "Час: \(newStringDate)"
        }
        viewModel.bindWeather.bind(\.temperature2m[indexPath.row], to: cell.temp, \.text) { value in
            return "Тэмпература: \(value)°C"
        }
        viewModel.bindWeather.bind(\.apparentTemperature[indexPath.row], to: cell.appTemp, \.text) { value in
            return "Уяўная тэмпература: \(value)°C"
        }
        viewModel.bindWeather.bind(\.rain[indexPath.row], to: cell.rain, \.text) { value in
            if value > 0 {
                return "Дождж: \(value)мм"
            } else {
                return "Без дажджоў"
            }
        }
        viewModel.bindWeather.bind(\.snowfall[indexPath.row], to: cell.snow, \.text) { value in
            if value > 0 {
                return "Снег: \(value)мм"
            } else {
                return "Без снегу"
            }
        }
        viewModel.bindWeather.bind(\.cloudcover[indexPath.row], to: cell.cloud, \.text) { value in
            if value < 10 {
                return "Ясна"
            } else if value > 11 && value < 50 {
                return "Пераменная воблачнасць: \(value)%"
            } else {
                return "Воблачна: \(value)%"
            }
        }
        viewModel.bindWeather.bind(\.windspeed10m[indexPath.row], to: cell.wind, \.text) { value in
            return "Вецер: \(value)км/г"
        }
        cell.addShadow()
        return cell
    }
}
