//
//  MapViewModel.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation

struct Map {
    var latitude: Double
    var longitude: Double
}

class MapViewModel {
    let map: Map
    
    init(map: Map){
        self.map = map
    }
}
