//
//  CircleProgressView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/27.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {

    var progress: CGFloat = 0 {
        didSet {
            centerLabel.text = "\(Int(round(progress * 100)))" + "%"
            setNeedsDisplay()
        }
    }
    var color: UIColor = MyConfigation.ThemeColor
    var bgColor: UIColor = .red
    var lineWidth: CGFloat = 10.0
    var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
    private var centerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        let label = UILabel(frame: bounds)
        label.font = font
        label.textColor = color
        label.textAlignment = .center
        addSubview(label)
        centerLabel = label
    }
    
    override func draw(_ rect: CGRect) {//如果可以，使用CAShapeLayer+UIBezierPath来代替UIGraphicsGetCurrentContext方法，减少内存占用和CPU消耗
        let width = bounds.width
        let path: UIBezierPath = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        let radius = (width - lineWidth * 2) / 2.0
        

        let backgroundPath = UIBezierPath()
        backgroundPath.lineWidth = lineWidth
        backgroundPath.addArc(withCenter: CGPoint(x: width / 2.0, y: width / 2.0), radius: radius, startAngle: -CGFloat.pi / 2.0, endAngle: -CGFloat.pi / 2.0 + CGFloat.pi * 2, clockwise: true)
        bgColor.setStroke()
        backgroundPath.stroke()
        
        path.addArc(withCenter: CGPoint(x: width / 2.0, y: width / 2.0), radius: radius, startAngle: -CGFloat.pi / 2.0, endAngle: -CGFloat.pi / 2.0 + CGFloat.pi * 2 * progress, clockwise: true)
        color.setStroke()
        path.stroke()
    }

}
