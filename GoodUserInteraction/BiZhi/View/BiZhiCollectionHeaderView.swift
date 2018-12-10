//
//  BiZhiCollectionHeaderView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/11/28.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class BiZhiCollectionHeaderView: UICollectionReusableView {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func setupSubviews() {
        bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        imageView = UIImageView()
        imageView.frame = bounds
        addSubview(imageView)
    }
    
}
