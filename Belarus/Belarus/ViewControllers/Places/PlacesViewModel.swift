//
//  PlacesViewModel.swift
//  Belarus
//
//  Created by user on 17.10.22.
//

import Foundation
import UIKit

struct Places {
    enum TypePlaces: String{
        case castle = "Замкі"
        case nature = "Прырода"
        case church = "Царквы"
    }
    var type: TypePlaces
    var description: [String]
}


class PlacesViewModel {
    
    var placesArray = [Places(type: .castle, description: ["Нясвіжскі замак", "Косаўскі замак", "Мірскі замак", "Лідскі замак"]),
                       Places(type: .nature, description: ["тэрыконы", "крэйдавыя кар'еры", "возера Белае і Нарач"]),
                       Places(type: .church, description: ["царква ў Сар'і", "касцёл у Гервятах", "храм у Чачэрску"])]
    
}
