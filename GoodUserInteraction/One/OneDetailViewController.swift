//
//  OneDetailViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/12.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class OneDetailViewController: UIViewController {
    @IBOutlet var detailTableView: UITableView!
    var oldOffsetY: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        setStatusBarBackgroundColor(color: MyConfigation.ThemeColor)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarBackgroundColor(color: UIColor.clear)
    }

    func setStatusBarBackgroundColor(color: UIColor) {
        if let window = UIApplication.shared.value(forKey: "statusBarWindow") as? UIView {
            if let statusBar = window.value(forKey: "statusBar") as? UIView {
                statusBar.backgroundColor = color
                statusBar.alpha = color.isEqual(UIColor.clear) ? 0.0 : 1.0
            }
        }
    }
}

extension OneDetailViewController: UITableViewDelegate {
    
}

extension OneDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 * 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = "第" + String(indexPath.row) + "行"
        return cell
    }
}

extension OneDetailViewController: UIScrollViewDelegate {
    //如何区分向上滑动或者向下滑动？使用全局变量记录开始滑动的位置，滑动时作比较
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        oldOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > oldOffsetY + 10 {
            navigationController?.navigationBar.isHidden = true
        } else if (scrollView.contentOffset.y < oldOffsetY - 10) {
            navigationController?.navigationBar.isHidden = false
        }
    }
}
