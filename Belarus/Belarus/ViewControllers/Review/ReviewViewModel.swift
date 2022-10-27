//
//  ReviewViewModel.swift
//  Belarus
//
//  Created by user on 19.10.22.
//

import Foundation
import UIKit

struct Review {
    var imagePlace: [UIImage]
    var descriptionPlace: String
    var latitude: Double
    var longitude: Double
}

class ReviewViewModel {
    let review: Review
    
    init(review: Review){
        self.review = review
    }
    
}
