//
//  MyConfiguration.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/11.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class MyConfigation {
    static let ThemeColor: UIColor = UIColor(red: 0.0, green: 0.56284224989999998, blue: 0.31881666180000001, alpha: 1.0)
    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    static func getNavigationHeight(controller: UIViewController?) -> CGFloat {
        guard let c = controller else { return 64.0 }
        return UIApplication.shared.statusBarFrame.size.height + (c.navigationController?.navigationBar.frame.size.height ?? 0)
    }
}
