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

struct PlacesResponseModel {
    var description: String
        var image : [String]
        var location: GeoPoint
        var name: String
        var type: TypePlaces
}


