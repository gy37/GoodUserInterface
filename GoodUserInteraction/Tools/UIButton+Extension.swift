//
//  UIButton+Extension.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/13.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
//        let imageSize = imageView!.frame.size
//        let titleSize = titleLabel!.frame.size
//        let totalHeight = imageSize.height + titleSize.height + padding
//        let totalWidth = imageSize.width + imageSize.width + padding;

        imageEdgeInsets = UIEdgeInsets(
            top: -titleLabel!.intrinsicContentSize.height - 5,//-titleSize.height - 5,//-(totalHeight - imageSize.height),
            left: 0,//(frame.size.width - imageSize.width) / 2 - 5,
            bottom: 0,
            right: -titleLabel!.intrinsicContentSize.width//-titleSize.width
        )
        //intrinsicContentSize 控件的实际大小，根据内容自动确定的
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageView!.frame.size.width,//-(frame.size.width - titleSize.width) / 2 - 10,
            bottom: -imageView!.frame.size.height - 5,//-(totalHeight - titleSize.height),
            right: 0
        )

    }
}
