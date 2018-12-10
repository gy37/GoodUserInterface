//
//  ZoneViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/21.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

/**
 1.滑动时，切换上面图片显示大小
 2.上滑和下滑时都可以切换
 */
class ZoneViewController: UIViewController {
    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet var belowImage: UIImageView!
    @IBOutlet var aboveImage: UIImageView!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "QQ Zone";
        let constant = MyConfigation.ScreenHeight - MyConfigation.getNavigationHeight(controller: self) - aboveImage.frame.size.height
        topConstraint.constant = constant
        bottomConstraint.constant = constant
        contentScrollView.contentOffset = CGPoint(x: 0, y: constant)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func circleBigger(radius: CGFloat) {
        let imageCenter = CGPoint(x: aboveImage.frame.size.width / 2.0, y: aboveImage.frame.size.height / 2.0)
        let endPath = UIBezierPath(arcCenter: imageCenter, radius: radius, startAngle: -CGFloat.pi / 2.0, endAngle: 3 * CGFloat.pi / 2.0, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.white.cgColor
        shapeLayer.path = endPath.cgPath
        aboveImage.layer.mask = shapeLayer
//        let beginPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 0, startAngle: -CGFloat.pi / 2.0, endAngle: 3 * CGFloat.pi / 2.0, clockwise: true)
//        let shapeLayerAnimation = CABasicAnimation(keyPath: "path")//The key path of the property to be animated.
//        shapeLayerAnimation.fromValue = beginPath.cgPath
//        shapeLayerAnimation.toValue = endPath.cgPath
//        shapeLayerAnimation.duration = 1
//        shapeLayerAnimation.delegate = self
//        shapeLayerAnimation.isRemovedOnCompletion = true
//        shapeLayer.add(shapeLayerAnimation, forKey: "shapeAnimation")//A string that identifies the animation.
    }
}

extension ZoneViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        circleBigger(radius: scrollView.contentOffset.y / 2.0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}

extension ZoneViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print(#function)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(#function)
    }
}

