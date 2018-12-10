//
//  CircleView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/27.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var color: UIColor = MyConfigation.ThemeColor
    private let margin: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {//如果可以，使用CAShapeLayer+UIBezierPath来代替UIGraphicsGetCurrentContext方法，减少内存占用和CPU消耗
        let context = UIGraphicsGetCurrentContext()
        let width = rect.size.width
        let height = rect.size.height
        let centerX = width / 2.0
        let centerY = height / 2.0
        let radius = width / 2.0 - margin
        
//        context?.setLineWidth(1)
//        context?.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius + 5.0, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
//        UIColor.clear.setStroke()
//        context?.strokePath()
        
        context?.setLineWidth(1)
        context?.move(to: CGPoint(x: centerX, y: centerY))
        context?.addLine(to: CGPoint(x: centerX, y: 0))
        let endAngle = -CGFloat.pi / 2.0 + progress * CGFloat.pi * 2
        context?.addArc(center: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -CGFloat.pi / 2.0, endAngle: endAngle, clockwise: false)
        color.setFill()
        context?.fillPath()
    }
}
