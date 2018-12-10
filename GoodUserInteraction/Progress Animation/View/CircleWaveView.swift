//
//  CircleWaveView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/26.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class CircleWaveView: UIView {
    
    var progress: CGFloat = 0
    var waveColor: UIColor = MyConfigation.ThemeColor
    private var displayLink: CADisplayLink?//定时器
    private var amplitude: CGFloat = 0//振幅
    private var distanceX: CGFloat = 0//两个波形的水平距离
    private var distanceY: CGFloat = 0//两个波形的竖直距离
    private var scaleX: CGFloat = 0//x方向速度
    private var scaleY: CGFloat = 0//y方向速度
    private var offsetX: CGFloat = 0//距离左侧距离
    private var offsetY: CGFloat = 0//距离顶部距离
    private var cycle: CGFloat = 0//周期
    private var waveAlphaColor: UIColor!
    private let waveFillColor: UIColor = .groupTableViewBackground


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        initVariables()
        addDisplayLinkAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initVariables() {
        let height = frame.size.height
        let width = frame.size.width
        progress = 0
        amplitude = 6
        cycle = 2 * CGFloat.pi / width
        distanceX = 2 * CGFloat.pi / cycle * 0.5
        distanceY = amplitude * 0.4
        scaleX = 0.4
        scaleY = 0.1
        offsetX = 0
        offsetY = (1 - progress) * (height + amplitude * 2)
        waveAlphaColor = waveColor.withAlphaComponent(0.5)
    }
    
    private func addDisplayLinkAction() {
        weak var weakSelf = self
        displayLink = CADisplayLink(target: weakSelf!, selector: #selector(moveWave))
        displayLink?.add(to: .main, forMode: .commonModes)
    }
    
    @objc private func moveWave() {
        offsetX += scaleX * 0.5
        
        if offsetY <= 0 { removeWave() }
        setNeedsDisplay()
    }
    
    private func removeWave() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    override func draw(_ rect: CGRect) {//如果可以，使用CAShapeLayer+UIBezierPath来代替UIGraphicsGetCurrentContext方法，减少内存占用和CPU消耗
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.width / 2)
        waveFillColor.setFill()
        path.fill()
        path.addClip()
        
        drawWave(color: waveColor, offsetx: 0, offsety: 0)
        drawWave(color: waveAlphaColor, offsetx: distanceX, offsety: distanceY)
    }
    
    func drawWave(color: UIColor, offsetx: CGFloat, offsety: CGFloat) {
        let height = frame.size.height
        let width = frame.size.width
        let endOffsetY: CGFloat = (1 - progress) * (height + amplitude * 2)//y方向上的最大值

        if (offsetY > endOffsetY) {
            offsetY = max(offsetY - (offsetY - endOffsetY) * scaleY, endOffsetY)
        }else if (offsetY < endOffsetY) {
            offsetY = min(offsetY + (endOffsetY - offsetY) * scaleY, endOffsetY)
        }
        
        let path: UIBezierPath = UIBezierPath()
        for x in 0...Int(width) {
            let y: CGFloat = amplitude * sin(CGFloat(x) * cycle + offsetX + offsetx / width * 2 * CGFloat.pi) + offsetY + offsety
            if x == 0 {
                path.move(to: CGPoint(x: CGFloat(x), y: y - amplitude))
            } else {
                path.addLine(to: CGPoint(x: CGFloat(x), y: y - amplitude))
            }
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        color.set()
        path.fill()
    }
}
