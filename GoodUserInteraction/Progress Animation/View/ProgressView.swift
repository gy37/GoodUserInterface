//
//  ProgressView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/27.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    var progressColor = MyConfigation.ThemeColor
    var progress: CGFloat = 0 {
        didSet {
            let margin = borderWidth + padding
            let maxWidth = bounds.size.width - margin * 2
            let height = bounds.size.height - margin * 2
            progressView?.frame = CGRect(x: margin, y: margin, width: maxWidth * progress, height: height)
        }
    }
    private let borderWidth: CGFloat = 2.0
    private let padding: CGFloat = 1.0
    private var progressView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        let borderView = UIView(frame: bounds)
        borderView.layer.cornerRadius = bounds.size.height / 2.0
        borderView.layer.masksToBounds = true
        borderView.backgroundColor = .white
        borderView.layer.borderColor = progressColor.cgColor
        borderView.layer.borderWidth = borderWidth
        addSubview(borderView)
        
        let view = UIView()
        view.backgroundColor = progressColor
        view.layer.cornerRadius = (bounds.height - (borderWidth + padding) * 2) / 2
        view.layer.masksToBounds = true
        addSubview(view)
        progressView = view;
    }
}
