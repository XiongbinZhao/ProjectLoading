//
//  LoadingIndicatorA.swift
//  ProjectLoading
//
//  Created by Xiongbin Zhao on 2018-07-09.
//  Copyright © 2018 Xiongbin Zhao. All rights reserved.
//

import UIKit

class CircularLoadingIndicator: UIView {

    var strokeStart: CGFloat = 0.0
    var strokeEnd: CGFloat = 0.98
    var fromColor: UIColor = UIColor.black
    var toColor: UIColor = UIColor.white
    
    var lineWidth: CGFloat = 1.5 {
        didSet {
            configureLayer()
        }
    }
    
    override class var layerClass : AnyClass {
        return AngularGradientLayer.self
    }
    
    convenience init(frame: CGRect,
                     fromColor: UIColor = UIColor.black,
                     toColor: UIColor = UIColor.white,
                     lineWidth: CGFloat)
    {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        self.fromColor = fromColor
        self.toColor = toColor
        configureLayer()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayer()
    }
    
    public func startAnimating() {
        stopAnimating()
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.values = [0, 2 * Double.pi]
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotateAnimation.duration = 0.95
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.isRemovedOnCompletion = false
        layer.add(rotateAnimation, forKey: "rotationAnimation")
        isHidden = false
    }
    
    public func stopAnimating() {
        layer.removeAllAnimations()
        isHidden = true
    }
    
    private func configureLayer() {
        guard let layer = layer as? AngularGradientLayer else { return }
        layer.contentsScale = UIScreen.main.scale
        let side = min(bounds.width, bounds.height)
        layer.bounds = CGRect(x: 0, y: 0, width: side, height: side)
        layer.fromColor = fromColor
        layer.toColor = toColor
        layer.drawsAsynchronously = true
        layer.needsDisplayOnBoundsChange = true
        layer.setNeedsDisplay()
        layer.mask = createCircularMaskLayer()
    }
    
    private func createCircularMaskLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let circularBound = CGRect(x: 0,
                                   y: 0,
                                   width: bounds.width - lineWidth * 2,
                                   height: bounds.height - lineWidth * 2)
        shapeLayer.path = UIBezierPath(roundedRect: circularBound,
                                       cornerRadius: bounds.height/2).cgPath
        shapeLayer.position = CGPoint(x: lineWidth, y: lineWidth)
        shapeLayer.strokeColor = fromColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeStart = strokeStart
        shapeLayer.strokeEnd = strokeEnd
        return shapeLayer
    }
}
