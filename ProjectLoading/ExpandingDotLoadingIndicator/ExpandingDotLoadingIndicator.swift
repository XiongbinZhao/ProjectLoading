//
//  ExpandingDotLoadingIndicator.swift
//  ProjectLoading
//
//  Created by Xiongbin Zhao on 2018-07-14.
//  Copyright © 2018 Xiongbin Zhao. All rights reserved.
//

import UIKit

class ExpandingDotLoadingIndicator: UIView {
    
    private var dotLayers: [CALayer] = []
    private let dotLayerSpacing: CGFloat = 7
    private let dotLayersOriginY: [CGFloat] = [7, 9, 11, 9, 7]
    private let dotLayersExpandingLength: [CGFloat] = [25, 9, 12, 9, 25]
    private let lineWidth: CGFloat = 3
    private let dotColor: UIColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayer()
    }
    
    private func configureLayer() {
        for (idx, originY) in dotLayersOriginY.enumerated() {
            let dotLayer = CALayer()
            dotLayer.anchorPoint = .zero
            dotLayer.position = CGPoint(x: CGFloat(idx) * dotLayerSpacing, y: originY)
            dotLayer.bounds = CGRect(origin: dotLayer.position, size: CGSize(width: lineWidth, height: lineWidth))
            dotLayer.cornerRadius = lineWidth/2
            dotLayer.backgroundColor = dotColor.cgColor
            dotLayers.append(dotLayer)
            layer.addSublayer(dotLayer)
        }
    }
    
    func startAnimating() {
        for (idx, animatedDotLayer) in dotLayers.enumerated() {
            animatedDotLayer.removeAllAnimations()
            addAnimation(for: animatedDotLayer, expandingLength: dotLayersExpandingLength[idx])
        }
    }
    
    func stopAnimating() {
        for animatedDotLayer in dotLayers {
            animatedDotLayer.removeAllAnimations()
        }
    }
    
    func addAnimation(for dotLayer: CALayer, expandingLength: CGFloat) {
        let position = dotLayer.position
        let dotRadius = dotLayer.bounds.width
        
        let originBounds = CGRect(x: position.x, y: position.y, width: dotRadius, height: dotRadius)
        let expandedBounds = CGRect(x: position.x, y: position.y, width: dotRadius, height: dotRadius + expandingLength)
        let expandingEndBounds = CGRect(x: position.x, y: position.y, width: dotRadius, height: dotRadius + 6)
        
        let expandingAnimation = CAKeyframeAnimation(keyPath: "bounds")
        
        expandingAnimation.values = [
            originBounds,
            expandedBounds,
            expandingEndBounds,
            originBounds
        ]
        expandingAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        expandingAnimation.duration = 1
        expandingAnimation.beginTime = 0
        expandingAnimation.isRemovedOnCompletion = false
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "position")
        bounceAnimation.values = [position,
                                  CGPoint(x: position.x, y: 0),
                                  position]
        bounceAnimation.duration = 0.8
        bounceAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bounceAnimation.beginTime = expandingAnimation.beginTime + expandingAnimation.duration
        bounceAnimation.isRemovedOnCompletion = false
        
        let animations = [expandingAnimation, bounceAnimation]
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = animations.reduce(0) { $0 + $1.duration }
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = .greatestFiniteMagnitude
        
        
        dotLayer.add(animationGroup, forKey: "expandingAnimation")
    }
}
