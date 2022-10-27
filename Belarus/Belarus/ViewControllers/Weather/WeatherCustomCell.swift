//
//  WeatherCustomCell.swift
//  Belarus
//
//  Created by user on 24.10.22.
//

import Foundation
import UIKit

class WeatherCustomCell: UICollectionViewCell {
    
    let placesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let time = UILabel()
    
    let temp = UILabel()
    
    let appTemp = UILabel()
    
    let rain = UILabel()
    
    let snow = UILabel()
    
    let cloud = UILabel()
    
    let wind = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        time.text = nil
        temp.text = nil
        appTemp.text = nil
        rain.text = nil
        snow.text = nil
        cloud.text = nil
        wind.text = nil
    }
    
    func addViews() {
        let labelArray = [time,temp,appTemp,rain,snow,cloud,wind]
        labelArray.enumerated().forEach{ index, label in
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            labelArray[index].topAnchor.constraint(equalTo: index == 0 ? topAnchor : labelArray[index - 1].bottomAnchor).isActive = true
            labelArray[index].leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            labelArray[index].trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            labelArray[index].heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
}
