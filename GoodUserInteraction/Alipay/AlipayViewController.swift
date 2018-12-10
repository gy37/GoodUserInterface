//
//  AlipayViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/13.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit
import MJRefresh

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let functionHeaderViewHeight:CGFloat = 95
let singleAppHeaderViewHeight:CGFloat = 60

/**
 1.顶部多个view，底部tableview，上下一块儿滑动
 2.上滑tableview，view跟着上滑，并渐变顶部按钮，显示隐藏的view
 */
class AlipayViewController: UIViewController {
    let topOffsetY = functionHeaderViewHeight + singleAppHeaderViewHeight
    
    lazy var mainScrollView: UIScrollView = {//
        let height = SCREEN_HEIGHT - 64
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: height))
        scroll.delegate = self
        scroll.contentSize = CGSize(width: SCREEN_WIDTH, height: 100)
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: topOffsetY, left: 0, bottom: 0, right: 0)//通过设置滚动条位置，从tableview所在位置开始
        return scroll
    }()
    
    lazy var navView: UIView = {//导航栏1 蓝色背景
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor(red: 65/255.0, green: 128/255.0, blue: 1, alpha: 1)
        return view
    }()
    
    lazy var mainNavView: UIView = {//导航栏2 只显示账单图标的导航栏
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor.clear
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.setImage(#imageLiteral(resourceName: "home_bill"), for: UIControlState.normal)
        payButton.setTitle("账单", for: UIControlState.normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        payButton.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 0
        )
        payButton.sizeToFit()
        
        var newFrame = payButton.frame
        newFrame.origin.y = 20 + 10
        newFrame.origin.x = 10
        newFrame.size.width = newFrame.size.width + 10
        payButton.frame = newFrame
        
        view.addSubview(payButton)
        return view
    }()
    
    lazy var coverNavView: UIView = {//导航栏3 显示三个图标的导航栏
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor.clear
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.setImage(#imageLiteral(resourceName: "pay_mini"), for: UIControlState.normal)
        payButton.sizeToFit()
        var newFrame = payButton.frame
        newFrame.origin.y = 20 + 10
        newFrame.origin.x = 10
        newFrame.size.width = newFrame.size.width + 10
        payButton.frame = newFrame
        
        let scanButton = UIButton(type: UIButtonType.custom)
        scanButton.setImage(#imageLiteral(resourceName: "scan_mini"), for: UIControlState.normal)
        scanButton.sizeToFit()
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        scanButton.frame = newFrame
        
        let searchButton = UIButton(type: UIButtonType.custom)
        searchButton.setImage(#imageLiteral(resourceName: "camera_mini"), for: UIControlState.normal)
        searchButton.sizeToFit()
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        searchButton.frame = newFrame
        
        view.addSubview(payButton)
        view.addSubview(scanButton)
        view.addSubview(searchButton)
        
        view.alpha = 0//刚开始隐藏三个按钮
        return view
    }()
    
    lazy var mainTableView: MyTableView = {
        let tableviewHeight = 1000 - topOffsetY//设置一个比较大的值，平铺在scrollview上，禁用tableview滚动
        let table = MyTableView(frame: CGRect(x: 0, y: topOffsetY, width: SCREEN_WIDTH, height: tableviewHeight), style: UITableViewStyle.plain)
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var functionHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: functionHeaderViewHeight))
        view.backgroundColor = UIColor.clear
        
        let padding:CGFloat = 5.0
        let buttonWidth = SCREEN_WIDTH/4.0 - padding*2
        
        let scanButton = UIButton(type: UIButtonType.custom)
        scanButton.frame = CGRect(x: padding, y: padding, width: buttonWidth, height: buttonWidth)
        scanButton.setImage(#imageLiteral(resourceName: "home_scan"), for: UIControlState.normal)
        scanButton.setTitle("扫一扫", for: UIControlState.normal)
        scanButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        scanButton.alignImageAndTitleVertically()
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0, y: padding, width: buttonWidth, height: buttonWidth)
        payButton.setImage(#imageLiteral(resourceName: "home_pay"), for: UIControlState.normal)
        payButton.setTitle("付款", for: UIControlState.normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        payButton.alignImageAndTitleVertically()
        
        let cardButton = UIButton(type: UIButtonType.custom)
        cardButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0*2, y: padding, width: buttonWidth, height: buttonWidth)
        cardButton.setImage(#imageLiteral(resourceName: "home_card"), for: UIControlState.normal)
        cardButton.setTitle("卡券", for: UIControlState.normal)
        cardButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cardButton.alignImageAndTitleVertically()
        
        let xiuButton = UIButton(type: UIButtonType.custom)
        xiuButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0*3, y: padding, width: buttonWidth, height: buttonWidth)
        xiuButton.setImage(#imageLiteral(resourceName: "home_xiu"), for: UIControlState.normal)
        xiuButton.setTitle("到位", for: UIControlState.normal)
        xiuButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        xiuButton.alignImageAndTitleVertically()
        
        view.addSubview(scanButton)
        view.addSubview(payButton)
        view.addSubview(cardButton)
        view.addSubview(xiuButton)
        return view
    }()
    
    lazy var appHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: functionHeaderViewHeight, width: SCREEN_WIDTH, height: singleAppHeaderViewHeight))
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    lazy var headerView: UIView = {//function和appview的背景view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: functionHeaderViewHeight + singleAppHeaderViewHeight))
        view.backgroundColor = UIColor(red: 65/255.0, green: 128/255.0, blue: 1, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainScrollView)
        view.addSubview(navView)//自定义导航栏背景
        view.addSubview(mainNavView)//正常显示的导航栏
        view.addSubview(coverNavView)//向上滑动时显示出来的导航栏
        
        mainScrollView.addSubview(headerView)//头部视图，蓝色背景
        headerView.addSubview(functionHeaderView)//几个功能按钮
        headerView.addSubview(appHeaderView)//一行其他按钮
        mainScrollView.addSubview(mainTableView)//底部平铺的tableview
        
        //设置更改内容大小的闭包，加载更多数据后调用
        mainTableView.changeContentSize = { [weak self] contentSize in//此时contentsize即为当前大小
            guard let weakSelf = self else {return}
            weakSelf.updateContentSize(size: contentSize)
        }
        
        //上拉加载更多 footerRefreshing->loadMoreData->changeContentSize->updateContentSize
        mainScrollView.mj_footer = MJRefreshAutoNormalFooter { [weak self] in
            guard let weakSelf = self else {return}
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                weakSelf.mainScrollView.mj_footer.endRefreshing()
                weakSelf.mainTableView.loadeMoreData()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentSize(size: mainTableView.contentSize)
//        if UIApplication.shared.canOpenURL(URL(string: "AliPayDemo://")!) {
//            UIApplication.shared.openURL(URL(string: "AliPayDemo://")!)
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //更新内容size
    func updateContentSize(size:CGSize) {
        var contentSize = size
        contentSize.height = contentSize.height + topOffsetY
        mainScrollView.contentSize = contentSize
        var newframe = mainTableView.frame
        newframe.size.height = size.height
        mainTableView.frame = newframe
    }
}

extension AlipayViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        print("content offset: " + ("\(scrollView.contentOffset.y)"))
        // 松手时判断是否刷新
        let y = scrollView.contentOffset.y
        if y < -54 {//-65 {//header高度54
            mainTableView.mj_header.beginRefreshing()
        } else if y > 0 && y <= functionHeaderViewHeight {
            functionViewAnimation(offsetY: y)
        }
    }
    //动画效果，大于functionView一半时向下，小于一半时向上运动
    func functionViewAnimation(offsetY y:CGFloat) {
        if y > functionHeaderViewHeight / 2.0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,y: functionHeaderViewHeight), animated: true)
        } else {
            mainScrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("content offset: " + ("\(scrollView.contentOffset.y)"))
        let y = scrollView.contentOffset.y
        if y <= 0 {//下拉
            print("pulling down...")
            var newFrame = headerView.frame
            newFrame.origin.y = y //设置headerview frame的y值为scrollview y方向的偏移量，即可保持headerview固定，不随scrollview滚动
            headerView.frame = newFrame //设置蓝色背景位置
            print("headerview frame:" + NSStringFromCGRect(newFrame))
            newFrame = mainTableView.frame
            newFrame.origin.y = y + topOffsetY
            mainTableView.frame = newFrame
            print("tableview frame:" + NSStringFromCGRect(newFrame))
            
            //设置tableview偏移量，间接移动tableview
            mainTableView.setScrollViewContentOffSet(point: CGPoint(x: 0, y: y))
            
            //重置functionview位置
            newFrame = functionHeaderView.frame
            newFrame.origin.y = 0
            print("function headerview frame:" + NSStringFromCGRect(newFrame))
            functionHeaderView.frame = newFrame
        } else if y < functionHeaderViewHeight && y > 0 {//上拉，距离小于headerview上部分view高度
            print("pulling up...")
            //处理功能区隐藏和视差
            var newFrame = functionHeaderView.frame
            newFrame.origin.y = y // / 2  //设置functionheaderview frame的y值为scrollview y方向的偏移量，即可保持functionheaderview固定，不随scrollview滚动
            print("function headerview frame:" + NSStringFromCGRect(newFrame))
            functionHeaderView.frame = newFrame
            
            //处理透明度
            let alpha = y / functionHeaderViewHeight < 1 ? (1 - y /  functionHeaderViewHeight) : 0
            functionHeaderView.alpha = alpha
            if alpha > 0.5 {
                mainNavView.alpha = alpha
                coverNavView.alpha = 0
            } else {
                mainNavView.alpha = 0
                coverNavView.alpha = 1 - alpha
            }
        }
    }
}
//参考链接：https://github.com/seedotlee/AlipayIndexDemo
