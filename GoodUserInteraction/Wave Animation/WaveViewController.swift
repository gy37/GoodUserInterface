//
//  WaveViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/21.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

/**
 1.滑动开始波浪动画
 */
class WaveViewController: UIViewController {
    @IBOutlet var contentTableView: UITableView!
    var waveView: WaveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Wave Animation"
        waveView = WaveView.addToView(view: contentTableView.tableHeaderView!, frame: CGRect(x: 0, y: (contentTableView.tableHeaderView?.frame.height)! - 5, width: (contentTableView.tableHeaderView?.frame.width)!, height: 5))
        
    }
}


extension WaveViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _ = waveView.startWave()
    }
}

extension WaveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waveCell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}

extension WaveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
