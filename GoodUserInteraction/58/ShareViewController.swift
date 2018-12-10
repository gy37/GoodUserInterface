//
//  ShareViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/7/16.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var shareLabel: UILabel!
    
    @IBOutlet var fourButtons: [UIButton]!
    
    var contentStartFrame: CGRect!
    var contentEndFrame: CGRect!
    var fourButtonStartY: CGFloat!
    var fourButtonEndY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.isHidden = true
        contentEndFrame = contentView.frame
        contentStartFrame = contentView.frame
        contentStartFrame.origin.y = cancelButton.frame.origin.y
        let button = fourButtons.first!
        fourButtonEndY = button.frame.origin.y
        fourButtonStartY = contentView.frame.size.height
        shareLabel.alpha = 0.0
    }

    @IBAction func cancelShare(_ sender: UIButton) {
        dismissAnimation()
    }
    
    @IBAction func selectShare(_ sender: UIButton) {
        dismissAnimation()
    }
    
    func showAnimation() {
        backgroundView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.contentView.frame = self.contentEndFrame
            self.shareLabel.alpha = 1.0
            for button in self.fourButtons {
                var frame = button.frame
                frame.origin.y = self.fourButtonEndY + CGFloat(arc4random_uniform(20))
                button.frame = frame
            }
        }) { (finish) in
            UIView.animate(withDuration: 0.01, animations: {
                for button in self.fourButtons {
                    var frame = button.frame
                    frame.origin.y = self.fourButtonEndY
                    button.frame = frame
                }
            })
        }
    }
    
    func dismissAnimation() {
        UIView.animate(withDuration: 0.01, animations: {
            self.shareLabel.alpha = 0.0
            for button in self.fourButtons {
                var frame = button.frame
                frame.origin.y = self.fourButtonEndY + CGFloat(arc4random_uniform(20))
                button.frame = frame
            }
        }) { (finish) in
            UIView.animate(withDuration: 0.5, animations: {
                for button in self.fourButtons {
                    var frame = button.frame
                    frame.origin.y = self.fourButtonStartY
                    button.frame = frame
                }
                self.contentView.frame = self.contentStartFrame
            }, completion: { (finish) in
                self.backgroundView.isHidden = true
            })
        }
    }
}

extension ShareViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if backgroundView.isHidden {
            contentView.frame = contentStartFrame
            for button in fourButtons {
                var frame = button.frame
                frame.origin.y = fourButtonStartY
                button.frame = frame
            }
            showAnimation()
        } else {
            dismissAnimation()
        }
    }
}
