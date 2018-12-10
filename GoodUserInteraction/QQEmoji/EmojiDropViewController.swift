//
//  EmojiDropViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/7/24.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class EmojiDropViewController: UIViewController {
    @IBOutlet var emoji: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    var nextItem: UIView!
    var collisionCount: Int = 0
    
    lazy var animator = { () -> UIDynamicAnimator in
        let a = UIDynamicAnimator()
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func dropdownEmoji(to next: UIView, isLeft: Bool) {
        nextItem = next
        animator.removeAllBehaviors()
//        var frame1 = emoji.frame
//        frame1.origin.y -= 20
//        frame1.origin.x = nextItem.frame.origin.x + nextItem.frame.size.width / (isLeft ? 2.0 : 4.0)
//        emoji.frame = frame1
//
//        var frame2 = emoji.frame
//        frame2.origin.y -= 30
//        frame2.origin.x = nextItem.frame.origin.x + nextItem.frame.size.width / (isLeft ? 4.0 : 2.0)
//        emoji.frame = frame2

//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: emoji.center)
//        bezierPath.addQuadCurve(to: nextItem.center, controlPoint: CGPoint.zero)
//
//        let keyframeAnimation = CAKeyframeAnimation(keyPath: "frame")
////        keyframeAnimation.values = [frame1, frame2]
////        keyframeAnimation.keyTimes = [0.5, 0.2]
//        keyframeAnimation.path = bezierPath.cgPath
//        keyframeAnimation.duration = 0.5
//        keyframeAnimation.delegate = self
//        emoji.layer.add(keyframeAnimation, forKey: "keyframeAnimation")
        
        
        
        UIView.animate(withDuration: 0.2, animations: {
            var frame1 = self.emoji.frame
            frame1.origin.y -= 20
            frame1.origin.x = self.nextItem.frame.origin.x + self.nextItem.frame.size.width / (isLeft ? 2.0 : 4.0)
            self.emoji.frame = frame1
        }) { (finish) in
            UIView.animate(withDuration: 0.2, animations: {
                var frame2 = self.emoji.frame
                frame2.origin.y -= 30
                frame2.origin.x = self.nextItem.frame.origin.x + self.nextItem.frame.size.width / (isLeft ? 4.0 : 2.0)
                self.emoji.frame = frame2
            }, completion: { (finish) in
                print("animation stop time: \(Date())")
                //创建重力行为
                let gravityDown = UIGravityBehavior(items: [self.emoji])
                gravityDown.magnitude = 2
                self.animator.addBehavior(gravityDown)

                //创建碰撞行为
                let collision = UICollisionBehavior(items: [self.emoji])
                collision.collisionMode = .everything
                collision.addItem(self.nextItem)
                //        let width = self.view.frame.size.width
                //        let height = self.view.frame.size.height
                //        collision.addBoundary(withIdentifier: "1" as NSString, from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: height))
                //        collision.addBoundary(withIdentifier: "2" as NSString, from: CGPoint(x: 0, y: height), to: CGPoint(x: width, y: height))
                //        collision.addBoundary(withIdentifier: "3" as NSString, from: CGPoint(x: width, y: 0), to: CGPoint(x: width, y: height))
                let path = UIBezierPath(rect: self.nextItem.frame)
                collision.addBoundary(withIdentifier: "aaa" as NSString, for: path)
                collision.collisionDelegate = self
                self.animator.addBehavior(collision)

                let itemBehavior = UIDynamicItemBehavior(items: [self.emoji])
                itemBehavior.addItem(self.nextItem)
                itemBehavior.elasticity = 0.5;     //设置弹性越大弹的越猛（笔者试了几次，发现1是原来的力气反弹，比1大会弹回去加力，比1小会衰减）
                itemBehavior.friction = 0.5;       // 磨擦力
                itemBehavior.density = 0.5;      //密度，，密度*体积等于质量 物理元素越大密度越大，越难推动
                itemBehavior.resistance = 0;   // 抗阻力 0~CGFLOAT_MAX ，阻碍原有所加注的行为（如本来是重力自由落体行为，则阻碍其下落，阻碍程度根据其值来决定）
                itemBehavior.allowsRotation = false;//是否允许旋转
                self.animator.addBehavior(itemBehavior);
            })
        }
        
    }

}

extension EmojiDropViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dropdownEmoji(to: buttons[0], isLeft: false)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}


extension EmojiDropViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
//        print("collision end time: \(Date())")
        collisionCount += 1
        print(collisionCount)
        let index = buttons.index(of: nextItem as! UIButton)! + 1
        if collisionCount % (index == 1 || index == buttons.count - 1 ? 3 : 4) != 0 { return }
        collisionCount = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            if let id = identifier, id as! String == "aaa" {
                if index < self.buttons.count {
                    let currentItem = self.nextItem
                    self.nextItem = self.buttons[index]
                    self.dropdownEmoji(to: self.nextItem, isLeft: currentItem!.frame.origin.x > self.nextItem.frame.origin.x)
                }
            }
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
    }
}

extension EmojiDropViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation stop time: \(Date())")
        //创建重力行为
//        let gravityDown = UIGravityBehavior(items: [emoji])
//        gravityDown.magnitude = 2
//        animator.addBehavior(gravityDown)
        
        //创建碰撞行为
        let collision = UICollisionBehavior(items: [emoji])
        collision.collisionMode = .everything
        collision.addItem(nextItem)
        //        let width = view.frame.size.width
        //        let height = view.frame.size.height
        //        collision.addBoundary(withIdentifier: "1" as NSString, from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: height))
        //        collision.addBoundary(withIdentifier: "2" as NSString, from: CGPoint(x: 0, y: height), to: CGPoint(x: width, y: height))
        //        collision.addBoundary(withIdentifier: "3" as NSString, from: CGPoint(x: width, y: 0), to: CGPoint(x: width, y: height))
        let path = UIBezierPath(rect: nextItem.frame)
        collision.addBoundary(withIdentifier: "aaa" as NSString, for: path)
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        let itemBehavior = UIDynamicItemBehavior(items: [emoji])
        itemBehavior.addItem(nextItem)
        itemBehavior.elasticity = 0.5;     //设置弹性越大弹的越猛（笔者试了几次，发现1是原来的力气反弹，比1大会弹回去加力，比1小会衰减）
        itemBehavior.friction = 0.5;       // 磨擦力
        itemBehavior.density = 0.5;      //密度，，密度*体积等于质量 物理元素越大密度越大，越难推动
        itemBehavior.resistance = 0;   // 抗阻力 0~CGFLOAT_MAX ，阻碍原有所加注的行为（如本来是重力自由落体行为，则阻碍其下落，阻碍程度根据其值来决定）
        itemBehavior.allowsRotation = false;//是否允许旋转
        animator.addBehavior(itemBehavior);
            
    }
}
