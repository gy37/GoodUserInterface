//
//  OneViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/12.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

/**
 1.首页，向上滑动时，显示状态栏和选项卡；向下滑动到不能再滑动时，隐藏状态栏和选项卡；默认最顶部，隐藏状态栏和选项卡
    //好像是有一个白色view覆盖在状态栏和导航栏上，滑动tableview时改变view透明度；
    //自己通过控制状态栏是否隐藏来实现，动画效果不好。。。
 2.详情页，向上滑动时，隐藏导航栏；向下滑动时，显示导航栏
 3.首页左上角日期切换动画
    //三个pickerview
 //4.首页右上角城市和天气
 //5.内容放在一个pagecontroller里面，左右切换，日期也切换
 */

class OneViewController: BaseViewController {
    @IBOutlet var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "One"
        UIApplication.shared.isStatusBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }
    
}

extension OneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "oneCell", for: indexPath) as! OneTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320.0
    }
}

extension OneViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       UIApplication.shared.isStatusBarHidden = scrollView.contentOffset.y <= 7
    }
}
