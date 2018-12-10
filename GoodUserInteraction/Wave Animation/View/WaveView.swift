//
//  WaveView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/21.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class WaveView: UIView {
    var waveAmplitude: CGFloat = 2.0
    var waveSpeed: CGFloat = 10.0
    var waveTime: TimeInterval = 1.0
    var waveColor: UIColor = .white
    private var offsetX: CGFloat = 0.0
    private var waveDisplayLink: CADisplayLink?
    private var waveShapeLayer: CAShapeLayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        waveDisplayLink?.invalidate()
        waveDisplayLink = nil
    }
    
    static func addToView(view: UIView, frame: CGRect) -> WaveView {
        let waveView = WaveView(frame: frame)
        view.addSubview(waveView)
        return waveView
    }
    
    func startWave() -> Bool {
        if waveShapeLayer?.path != nil { return false }
        
        waveShapeLayer = CAShapeLayer()
        waveShapeLayer?.fillColor = waveColor.cgColor
        layer.addSublayer(waveShapeLayer!)
        
        weak var weakSelf = self
        waveDisplayLink = CADisplayLink(target: weakSelf!, selector: #selector(rollingWave))
        waveDisplayLink?.add(to: RunLoop.main, forMode: .commonModes)
        
        if waveTime > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + waveTime) {
                self.stopWave()
            }
        }
        return true
    }
    
    @objc private func rollingWave() {
        offsetX -= waveSpeed
        let width = frame.width
        let height = frame.height
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        
        var y: CGFloat = 0.0
        for x in 0...Int(width) {
            y = height * sin(0.01 * (waveAmplitude * CGFloat(x) + offsetX))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        waveShapeLayer?.path = path
    }
    
    private func stopWave() {
        let stopTime: TimeInterval = 1.0
        UIView.animate(withDuration: stopTime, animations: {
            self.alpha = 0.0//闭包中需要加上self，防止引起歧义
        }) { (finished) in
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
            self.waveShapeLayer?.path = nil
            self.alpha = 1.0
        }
    }
}
