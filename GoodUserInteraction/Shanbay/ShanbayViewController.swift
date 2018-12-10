//
//  ShanbayViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/7/17.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class ShanbayViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    var nextImageView: UIImageView!
    var threeImageViews = [UIImageView]()
    let imageViewCount: Int = 5
    var offsetX: CGFloat = 0
    var scrollWidth: CGFloat = 0
    var scrollHeight: CGFloat = 0
    var viewWidth: CGFloat = 0
    var viewHeight: CGFloat = 0
    var panStartPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupSubviews()
    }
    
    func setupSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(imageViewCount), height: scrollHeight)
        scrollView.isHidden = true
        let colors: [UIColor] = [.red, .green, .blue, .orange, .cyan, .purple, .brown]
        for i in 0..<imageViewCount {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))// CGFloat(i) * scrollWidth
            imageView.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
//            scrollView.addSubview(imageView)
            view.insertSubview(imageView, at: 0)
            threeImageViews.append(imageView)
            imageView.tag = 10 + i
            let pan = UIPanGestureRecognizer(target: self, action: #selector(ShanbayViewController.moveImageView(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(pan)
            if i != 0 { imageView.isHidden = true }
        }
        
    }
    
    @objc func moveImageView(_ pan: UIPanGestureRecognizer) {
        let currentView = pan.view!
//        print("currentView: \(currentView)")
        let point = pan.location(in: currentView)
        let translationPoint = pan.translation(in: currentView)
        let isPanLeft = translationPoint.x < 0
        var nextView: UIView?
        if isPanLeft {//向左滑
            if currentView.tag + 1 > 10 + imageViewCount - 1 { return }
            nextView = view.viewWithTag(currentView.tag + 1)
        } else {//向右滑  滑到第一个图片frame不对
            if currentView.tag - 1 < 10 { return }
            nextView = view.viewWithTag(currentView.tag - 1) //view.viewWithTag(0)为父view
        }
//        print(isPanLeft)
//        print("nextView: \(nextView!)")
        currentView.superview?.bringSubview(toFront: currentView)
        switch pan.state {
            case .began:
                panStartPoint = point
                nextView?.isHidden = false
                nextView?.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            case .changed:
                if isPanLeft {
//                print("point: \(point.x), panStartPoint: \(panStartPoint.x)")
//                print("currentView: \(currentView)")
                    var frame = currentView.frame
                    frame.origin.x = frame.origin.x + (point.x - panStartPoint.x)
                    currentView.frame = frame
                    
                    //缩放下一个view
                    let scale = currentView.frame.origin.x / viewWidth
//                print("currentViewFrame: \(currentView.frame.origin.x) ++++++++ scale: \(scale)")
//                print("nextViewFrame: \(nextView!.frame)")
                    nextView?.layer.transform = CATransform3DMakeScale(scale, scale, 1)
                } else {
//                    print("point: \(point.x), panStartPoint: \(panStartPoint.x)")
//                    print("currentView: \(currentView)")
//                    print("nextView: \(nextView!)")
                    var frame = currentView.frame
                    frame.origin.x = frame.origin.x + (point.x - panStartPoint.x)
                    currentView.frame = frame
                    
                    //缩放下一个view
                    let scale = currentView.frame.origin.x / viewWidth
//                    print("currentViewFrame: \(currentView.frame.origin.x) ++++++++ scale: \(scale)")
//                    print("currentViewFrame: \(currentView.frame)")
//                    print("nextViewFrame: \(nextView!.frame)")
                    nextView?.isHidden = false
                    nextView?.layer.transform = CATransform3DMakeScale(scale, scale, 1)
            }

            case .ended:
                UIView.animate(withDuration: 0.3, animations: {
                    if isPanLeft {
                        var frame = currentView.frame
                        frame.origin.x = frame.origin.x > -self.viewWidth / 2.0 ? 0 : -self.viewWidth
                        if frame.origin.x == -self.viewWidth { currentView.isHidden = true }
                        currentView.frame = frame
                        nextView?.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                    } else {
                        var frame = currentView.frame
                        frame.origin.x = frame.origin.x > self.viewWidth / 2.0 ? self.viewWidth : 0
                        if frame.origin.x == self.viewWidth { currentView.isHidden = true }
                        currentView.frame = frame
                        nextView?.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                    }
                    
                }) { (finish) in
                    currentView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    nextView?.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            default:
                return
        }
    }
   
}

extension ShanbayViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offsetX = scrollView.contentOffset.x
        let currentIndex = Int(offsetX / scrollWidth)
//        let currentImageView = threeImageViews[currentIndex]
        if currentIndex == imageViewCount - 1 { return }
        nextImageView = threeImageViews[currentIndex + 1 > imageViewCount - 1 ? imageViewCount - 1 : currentIndex + 1]
//        scrollView.bringSubview(toFront: currentImageView)
        let scale = CGFloat(Int(offsetX) % Int(scrollWidth)) / scrollWidth
        nextImageView.layer.transform = CATransform3DMakeScale(scale, scale, 1)
//        nextImageView.layer.position = CGPoint(x: CGFloat(2 * currentIndex + 2 + 1) * scrollWidth / 2.0 , y: scrollHeight / 2.0)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }    
}
