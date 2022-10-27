//
//  MapViewController.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation
import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    
    init(viewModel:MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cornflowers4")
        image.contentMode = .scaleToFill
        image.alpha = 0.8
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Тут вы можаце паглядзець месцазнаходжанне аб'екта, які цікавіць ваc"
        label.textAlignment = .center
        return label
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.alpha = 0.9
        map.layer.cornerRadius = 20
        return map
    }()
    
    private var buttonArray = [UIButton(),UIButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeButton()
        let plase = Capital(coordinate: .init(latitude: viewModel.map.latitude, longitude: viewModel.map.longitude))
        mapView.addAnnotation(plase)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.mapView.centerToLocation(.init(latitude: self!.viewModel.map.latitude, longitude: self!.viewModel.map.longitude), radius: 1000)
        }
    }
    
    private func configureUI() {
        view.addSubview(mainImage)
        view.translatesAutoresizingMaskIntoSubviews()
        mainImage.addSubviews(descriptionLabel, mapView)
        mainImage.translatesAutoresizingMaskIntoSubviews()
        mainImage.addShadowOnSubviews()
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainImage.topAnchor, constant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            
            mapView.topAnchor.constraint(equalTo: mainImage.topAnchor, constant: 200),
            mapView.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -30)
        ])
    }
    
    private func makeButton() {
        let num = [1,2]
        let title = ["+", "-"]
        buttonArray.enumerated().forEach{ index ,button in
            button.backgroundColor = .gray
            button.layer.cornerRadius = 20
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addShadow()
            button.addTarget(self, action: #selector(didTapZoom), for: .touchUpInside)
            mapView.addSubview(button)
            buttonArray[index].tag = num[index]
            buttonArray[index].setTitle(title[index], for: .normal)
            
            buttonArray[index].topAnchor.constraint(equalTo: index == 0 ? mapView.topAnchor : buttonArray[index - 1].bottomAnchor, constant: 5 ).isActive = true
            buttonArray[index].trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20).isActive = true
            buttonArray[index].widthAnchor.constraint(equalToConstant: 40).isActive = true
            buttonArray[index].heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    
    @objc private func didTapZoom(sender: UIButton) {
        switch sender.tag {
        case 1 :
            mapView.region.span.longitudeDelta /= 1.1
            mapView.region.span.latitudeDelta /= 1.1
        case 2 :
            mapView.region.span.longitudeDelta *= 1.1
            mapView.region.span.latitudeDelta *= 1.1
        default:
            print("Error")
        }
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, radius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        setRegion(region, animated: true)
    }
}
