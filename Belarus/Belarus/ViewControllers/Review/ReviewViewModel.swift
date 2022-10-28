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
    let review: PlacesResponseModel
    
    init(review: PlacesResponseModel){
        self.review = review
    }
    
    func downloadImage() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/belarus-8fdea.appspot.com/o/places%2FIMG_7188.jpg?alt=media&token=29bdd120-c3a4-42c6-89a9-20babf2a2d99")!
        
        var request = URLRequest(url: url)

        var new = UIImage()
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                new = image ?? UIImage()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
