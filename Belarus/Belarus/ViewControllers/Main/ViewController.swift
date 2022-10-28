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
//        let db =  Firestore.firestore().collection("places")
//        let new = DatabaseService()
//        new.my()
//        print(new.newPlaces)
        
//        db.whereField("type", isEqualTo: "Царквы").getDocuments { snapshot, error in
//            for document in snapshot!.documents {
//                print(document.data())
//                print(document.data()["name"])
//            }
//        }
//        db.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
////                    print("\(document.documentID) => \(document.data())")
//                    print(document.data()["type"])
//                }
//            }
//        }
//        db.document("AEvtmeldyH4TRLpvWT7b").getDocument { snap, error in
//            print(snap?.data())
//        }

//        db.addDocument(data: [
//            "description":"Лідскі замак - унікальны помнік абарончага дойлідства. Горад Ліда знаходзіцца ў Гродзенскай вобласці за 112 км на паўночны ўсход ад Гродна. Тут захаваўся сярэднявечны замак - выдатны помнік абарончага дойлідства XIV ст. Будаўніцтва замка было распачата ў 1323 г. вялікім князем Вялікага княства Літоўскага Гедымінам Замак узводзіўся на насыпным пясчаным узгорку, акружаным багністымі берагамі рэк Лідзея і Каменк і ровам, які злучае гэтыя рэкі з поўдня і які адлучае замак ад горада За сваю гісторыю замак вытрымаў мноства бітваў і аблог. У XVIII ст. ён страціў сваё стратэгічна значэнне і пачаў паступова разбурацца У 1891 годзе цэнтральная частка горада Ліда моцна пацярпела пры пажары і камяні з паўднёва-заходня вежы і часткі заходняй сцяны замка былі выкарыстаны для аднаўлення будынкаў, якія пацярпелі а агню У 1920-х пачалася кансервацыя замка, якая завяршылася ў 1982 г. Цяпер вядзецца рэстаўрацыя сцен і веж Лідскі замак, як і Мірскі замак, знаходзіцца пад аховай дзяржавы.",
//            "image": ["https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7204.jpg?alt=media&token=b705171e-3433-4059-a16d-263924008181","https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7205.jpg?alt=media&token=65d39372-429c-46ef-ad8e-20c7f2f66a87","https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7206.jpg?alt=media&token=55fe9694-4951-4794-a548-1883e70e593e","https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7207.jpg?alt=media&token=d3b89791-01b0-4c61-a4f6-fbc4f5e05e57","https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7208.jpg?alt=media&token=10a8de8d-5bcf-4978-90dc-cbb9d3873eea","https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7209.jpg?alt=media&token=48a0e871-deec-4d38-acfe-3ce0767ad61e"],
//            "location": GeoPoint(latitude: 53.887416, longitude: 25.302808),
//            "name": "Лідскі замак",
//            "type": "Замкі"
//        ])
        
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

