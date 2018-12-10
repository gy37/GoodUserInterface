//
//  MyTableView.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/13.
//  Copyright © 2018 smarfid. All rights reserved.
//


import UIKit
import MJRefresh

class MyTableView: UITableView {
    var numberRows:Int = 50
    var changeContentSize:((_ contentSize:CGSize)->())?

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        weak var weakSelf = self
        dataSource = weakSelf
        delegate = weakSelf
        rowHeight = (1000 - 140) / 20;
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mj_header = MJRefreshNormalHeader { [weak self] in
            guard let weakSelf = self else {return}
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                // Put your code which should be executed with a delay here
                weakSelf.mj_header.endRefreshing()
                weakSelf.reloadData()
            })
        }
//        mj_header = MJRefreshNormalHeader(refreshingBlock: {
//        })
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadeMoreData() {//加载更多时，增加数据，刷新页面，改变contentsize
        numberRows += 10
        reloadData()
        changeContentSize?(contentSize)
    }
    
    func setScrollViewContentOffSet(point:CGPoint) {
        if !mj_header.isRefreshing() {
            contentOffset = point
        }
    }
}

extension MyTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRows
    }
}

extension MyTableView: UITableViewDelegate {
    
}
