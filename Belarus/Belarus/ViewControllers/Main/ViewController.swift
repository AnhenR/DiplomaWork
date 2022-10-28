//
//  ViewController.swift
//  Belarus
//
//  Created by user on 13.10.22.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Беларусь - краіна кантрастаў. Маляўнічы край, які аб'ядноўвае старажытную гісторыю, сучасныя тэхналогіі і ўнікальную прыроду, тут ёсць нешта блізкае для кожнага сэрца. Акуніцеся ў глыбіні стагоддзяў і на свае вочы прасочыце развіццё еўрапейскай культуры, наведаўшы шматлікія помнікі даўніны і месцы высокай гісторыка-культурнай важнасці. Адчуйце сваю блізкасць са светам, дакрануўшыся да першароднай прыроды беларускіх лясоў і вадаёмаў. Беларусь - краіна, якую хочацца даследаваць. На жаль многія жыхары краіны не ведаюць і паловы выдатных мясцін, якія ёсць у Беларусі, але гэта лёгка выправіць! Мы падабралі для вас месцы, якія, на наш погляд, могуць правесці вас па гісторыі і культуры краіны."
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cornflowers")
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let cityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Азнаёміцца", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 30
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.backButtonTitle = "Выйсці"
        view.addSubview(mainImage)
        view.translatesAutoresizingMaskIntoSubviews()
        view.addAlpha()
        mainImage.addSubviews(mainLabel, cityButton)
        mainImage.translatesAutoresizingMaskIntoSubviews()
        mainImage.addShadowOnSubviews()
        mainImage.addAlpha()
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: mainImage.topAnchor, constant: 70),
            mainLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: -10),
            mainLabel.heightAnchor.constraint(equalToConstant: 500),
            
            cityButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            cityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            cityButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        cityButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc func didTap() {
        navigationController?.pushViewController(PlacesViewController(), animated: true)
    }
}

