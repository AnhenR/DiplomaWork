//
//  ViewExtension.swift
//  Belarus
//
//  Created by user on 16.10.22.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(shadowColor: UIColor = .black,shadowOffset: CGSize = CGSize(width: 20, height: 10),shadowOpacity: Float = 0.6,shadowRadius: Double = 15 ) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addGradient(colors:[Any] = [UIColor.white.cgColor,UIColor.gray.cgColor, UIColor.darkGray.cgColor], startPoint: CGPoint = CGPoint.Point.topLeading.point , endPoint: CGPoint = CGPoint.Point.bottomTrailing.point, type: CAGradientLayerType = .axial ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.type = type
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadowOnSubviews() {
        subviews.forEach{$0.addShadow()}
    }
    
    func addAlpha() {
        subviews.forEach{$0.alpha = 0.9}
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
    
    func translatesAutoresizingMaskIntoSubviews() {
        subviews.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
