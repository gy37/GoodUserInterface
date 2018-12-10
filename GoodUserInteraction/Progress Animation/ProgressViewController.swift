//
//  ProgressViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/26.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

/*
 1.各种进度条效果（波浪，直线，圆环，圆盘）
 */

class ProgressViewController: UIViewController {
    var timer: Timer?
    var waveView: CircleWaveView!
    var progressView: ProgressView!
    var circleProgressView: CircleProgressView!
    var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Progress Animation"
        waveView = CircleWaveView(frame: CGRect(x: 20, y: 100, width: 150, height: 150))
        view.addSubview(waveView)

        progressView = ProgressView(frame: CGRect(x: 200, y: 100, width: 150, height: 20))
        view.addSubview(progressView)
        
        circleProgressView = CircleProgressView(frame: CGRect(x: 20, y: 300, width: 150, height: 150))
        view.addSubview(circleProgressView)
        
        circleView = CircleView(frame: CGRect(x: 200, y: 300, width: 150, height: 150))
        view.addSubview(circleView)
        
        startTimer()
    }
    
    func startTimer() {
        weak var weakSelf = self
        timer = Timer(timeInterval: 0.2, target: weakSelf!, selector: #selector(addProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    @objc func addProgress() {
        waveView.progress += 0.01
        progressView.progress += 0.01
        circleProgressView.progress += 0.01
        circleView.progress += 0.01
        
        if waveView.progress >= 1 {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
