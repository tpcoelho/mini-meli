//
//  ShimmerView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 26/07/25.
//

import UIKit

class ShimmerView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmer()
    }
    
    private func setupShimmer() {
        gradientLayer.name = "shimmer"
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.cornerRadius = min(bounds.height / 2, 5)
        
        let color = Colors.Action.disabled
        let gradientColorOne = color.withAlphaComponent(0.5).cgColor
        let gradientColorTwo = color.withAlphaComponent(0.8).cgColor
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        layer.addSublayer(gradientLayer)
        gradientLayer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        startShimmer()
    }
    
    func startShimmer() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.25
        gradientLayer.add(animation, forKey: "shimmer")
    }
    func stopShimmering() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}
