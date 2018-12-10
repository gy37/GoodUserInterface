//
//  UIViewController+Extension.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/11.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String, confirmHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "Confirm", style: .default, handler: confirmHandler)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
