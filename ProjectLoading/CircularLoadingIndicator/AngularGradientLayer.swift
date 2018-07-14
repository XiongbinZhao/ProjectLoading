//
//  AngularGradientLayer.swift
//  ProjectLoading
//
//  Created by Xiongbin Zhao on 2018-07-13.
//  Copyright © 2018 Xiongbin Zhao. All rights reserved.
//

import UIKit

class AngularGradientLayer: CALayer {
    
    let initialRGBValue: CGFloat = 0
    
    var fromColor: UIColor = UIColor.blue
    var toColor: UIColor = UIColor.white
    
    var startPoint: CGPoint {
        return CGPoint(x: bounds.midX, y: 0)
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var currentPoint = startPoint
        var count = 0
        let perimeter = Int((bounds.width + bounds.height) * 2)
        let colors = generateColorArray(for: perimeter)
        while count < perimeter {
            if currentPoint.y <= 0 && currentPoint.x != 0 {
                currentPoint.x = max(currentPoint.x - 1, 0)
            } else if currentPoint.x <= 0 && currentPoint.y != bounds.height {
                currentPoint.y = max(currentPoint.y + 1, 0)
            } else if currentPoint.y == bounds.height && currentPoint.x != bounds.width {
                currentPoint.x = max(currentPoint.x + 1, 0)
            } else if currentPoint.x == bounds.width && currentPoint.y != 0 {
                currentPoint.y = max(currentPoint.y - 1, 0)
            }
            
            let line = UIBezierPath()
            line.move(to: currentPoint)
            line.addLine(to: center)
            colors[count].setStroke()
            line.stroke()
            
            count = count + 1
        }
        UIGraphicsPopContext()
    }
    
    private func generateColorArray(for num: Int) -> [UIColor] {
        var fromRed: CGFloat = initialRGBValue
        var fromGreen: CGFloat = initialRGBValue
        var fromBlue: CGFloat = initialRGBValue
        var fromAlpha: CGFloat = initialRGBValue
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = initialRGBValue
        var toGreen: CGFloat = initialRGBValue
        var toBlue: CGFloat = initialRGBValue
        var toAlpha: CGFloat = initialRGBValue
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        var result: [UIColor] = []
        for i in 0...num-1 {
            let red: CGFloat = fromRed + (toRed - fromRed) / CGFloat(num) * CGFloat(i)
            let green: CGFloat = fromGreen + (toGreen - fromGreen) / CGFloat(num) * CGFloat(i)
            let blue: CGFloat = fromBlue + (toBlue - fromBlue) / CGFloat(num) * CGFloat(i)
            let alpha: CGFloat = fromAlpha + (toAlpha - fromAlpha) / CGFloat(num) * CGFloat(i)
            let color = UIColor.init(red: red,
                                     green: green,
                                     blue: blue,
                                     alpha: alpha)
            result.append(color)
        }
        return result
    }
}
