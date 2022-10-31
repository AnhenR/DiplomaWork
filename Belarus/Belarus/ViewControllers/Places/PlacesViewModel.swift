//
//  PlacesViewModel.swift
//  Belarus
//
//  Created by user on 17.10.22.
//

import Foundation
import UIKit
import FirebaseFirestore

enum TypePlaces: String, CaseIterable {
    case castle = "Замкі"
    case nature = "Прырода"
    case church = "Царквы"
    
    var description: String {
        switch self {
        case .castle:
            return "Замкі"
        case .nature:
            return "Прырода"
        case .church:
            return "Царквы"
        }
    }
}

struct Places {
    var type: TypePlaces
    var description: [String]
}


class PlacesViewModel {
    
    let db = Firestore.firestore().collection("places")
    var newPlaces: [PlacesResponseModel] = []
    var displayPlaces: [[PlacesResponseModel]] = []
    
    func my(completion: @escaping VoidHandler) {
        db.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let result = snapshot?.documents else {return}
                result.forEach{ places in
                    guard let description = places.data()["description"] as? String,
                    let image = places.data()["image"] as? [String],
                    let location = places.data()["location"] as? GeoPoint,
                    let name = places.data()["name"] as? String,
                          let type = places.data()["type"] as? String else { return }
                    let place = PlacesResponseModel(description: description, image: image, location: location, name: name, type: TypePlaces(rawValue: type)!)
                    self.newPlaces.append(place)
                }
                self.configureDisplayPlaces(completion: completion)
            }
        }
    }
    
    func configureDisplayPlaces(completion: @escaping VoidHandler) {
        let castle = newPlaces.filter { $0.type == .castle }
        let church = newPlaces.filter { $0.type == .church }
        let nature = newPlaces.filter { $0.type == .nature }
        
        displayPlaces.append(castle)
        displayPlaces.append(church)
        displayPlaces.append(nature)
        completion()
    }
}
