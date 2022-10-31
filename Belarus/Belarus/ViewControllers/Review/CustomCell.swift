//
//  CustomCell.swift
//  Belarus
//
//  Created by user on 18.10.22.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {
    let placesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        placesImage.image = nil
    }
    
    func addViews() {
        addSubview(placesImage)
        placesImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placesImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        placesImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        placesImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    func configure(newImage: String) {
        
        Task() {
            
            let url = URL(string: newImage )!
            
            let request = URLRequest(url: url)
            do {
                let data = try await URLSession.shared.data(for: request).0
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                self.placesImage.image = image
                }
            } catch {
                
            }
        }
    }
}
