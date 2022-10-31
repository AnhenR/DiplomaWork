//
//  PlacesViewController.swift
//  Belarus
//
//  Created by user on 13.10.22.
//

import Foundation
import UIKit

class PlacesViewController: UIViewController {
    
    private let viewModel = PlacesViewModel()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cornflowers2")
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Некалькі выдатных мясцін Беларусі, якія варта наведаць!"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var placesTableView = UITableView()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTable()
        viewModel.my {
            self.placesTableView.reloadData()
        }
        viewModel.activityIndicatorVisability.bind(to: activityIndicator, \.isHidden)
        activityIndicator.startAnimating()
    }
    
    private func configureUI() {
        navigationItem.backButtonTitle = "Выйсці"
        view.addSubviews(mainImage, activityIndicator)
        view.translatesAutoresizingMaskIntoSubviews()
        view.bringSubviewToFront(activityIndicator)
        mainImage.addSubview(descriptionLabel)
        mainImage.addShadowOnSubviews()
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainImage.topAnchor, constant: 100),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 250),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
            activityIndicator.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureTable() {
        mainImage.addSubview(placesTableView)
        mainImage.translatesAutoresizingMaskIntoSubviews()
        mainImage.addAlpha()
        placesTableView.layer.cornerRadius = 10
        placesTableView.backgroundColor = .gray
        NSLayoutConstraint.activate([
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            placesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            placesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            placesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        placesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlacesCell")
        placesTableView.dataSource = self
        placesTableView.delegate = self
    }
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.displayPlaces.count
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.displayPlaces[section].first?.type.description
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReviewViewController(viewModel: .init(review: viewModel.displayPlaces[indexPath.section][indexPath.row]))
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.displayPlaces[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath as IndexPath)
        cell.textLabel?.text = viewModel.displayPlaces[indexPath.section][indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .darkGray
        cell.alpha = 0.9
        return cell
    }
}
