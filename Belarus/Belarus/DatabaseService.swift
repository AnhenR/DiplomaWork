//
//  Data.swift
//  Belarus
//
//  Created by user on 27.10.22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

struct NewData {
    var description: String
    var image : [String]
    var location: GeoPoint
    var name: String
    var type: String
    
    var dictionary: [String: Any] {
        return[
            "description": description,
            "image": image,
            "location": location,
            "name": name,
            "type": type
        ]
    }
}

struct PlacesResponseModel {
    var description: String
        var image : [String]
        var location: GeoPoint
        var name: String
        var type: TypePlaces
}

extension NewData{
    init?(dictionary: [String : Any]) {
        guard let description = dictionary["description"] as? String,
              let image = dictionary["image"] as? [String],
              let location = dictionary["location"] as? GeoPoint,
              let name = dictionary["name"] as? String,
              let type = dictionary["type"] as? String
        else { return nil }
        
        self.init(description: description, image: image, location: location, name: name,type: type)
    }
}



