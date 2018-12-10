//
//  HomePageViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/11.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit
import AVKit

class HomepageViewController: BaseViewController {
    var items: [String]!
    var colors: [UIColor]!
    var videos: [String]!
    @IBOutlet var homepageTableView: UITableView!
    lazy var avplayerController = { () -> AVPlayerViewController in
        let avplayer = AVPlayer()
        let a = AVPlayerViewController()
        a.player = avplayer
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2)
        items = ["One Homepage", "Alipay Homepage", "QQ Zone Advertisement", "Wave Animation", "58 Share View", "Shanbay Image Switch", "QQ Emoji Drop Effect", "Progress Animation", "ZhiHu Advertisement", "BiZhi Page", "MeiTuan Order", "MeiTuan Store", "TMall Homepage"]
        videos = ["One.MP4", "Alipay.MP4", "QQ Zone.MOV", "", "58.MP4", "Shanbay.MP4", "QQ Emoji.MP4", "", "ZhiHu.MP4", "bizhiHD.MP4", "MeiTuan1.MP4", "MeiTuan2.MP4", "TMall.MP4"]
        homepageTableView.tableFooterView = UIView()
    }

    @IBAction func clickedBottomButton(_ sender: UIButton) {
        showDefaultAlert(title: "Hello", message: "Do you want to open this link?", confirmHandler: { (action) in
            let webView = MyWebViewController(linkUrl: "https://www.baidu.com")
            self.navigationController?.pushViewController(webView, animated: true)
        }) { (action) in
            print(action.title ?? "Cancel button clicked!")
        }
    }
    
    

}


extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homepageCell")!
        cell.textLabel?.text = items[indexPath.row]
        if indexPath.row == 5 {
            cell.backgroundColor = UIColor.orange
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    
}

extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row)th row is clicked, is going to \(items[indexPath.row])")
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showOne", sender: cell)
        case 1:
            performSegue(withIdentifier: "showAliPay", sender: cell)
        case 2:
            performSegue(withIdentifier: "showZone", sender: cell)
        case 3:
            performSegue(withIdentifier: "showWave", sender: cell)
        case 4:
            performSegue(withIdentifier: "showShareView", sender: cell)
        case 5:
            performSegue(withIdentifier: "showShanbayImage", sender: cell)
        case 6:
            performSegue(withIdentifier: "showQQEmojiView", sender: cell)
        case 7:
            performSegue(withIdentifier: "showProgress", sender: cell)
        case 8:
            performSegue(withIdentifier: "showZhihu", sender: cell)
        case 9:
            performSegue(withIdentifier: "showBiZhi", sender: cell)
        default:
            let path = Bundle.main.path(forResource: videos[indexPath.row], ofType: nil)
            if let p = path {
                avplayerController.player?.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: p)))
                avplayerController.navigationItem.title = videos[indexPath.row]
                navigationController?.pushViewController(avplayerController, animated: true)
            }
            return
        }
    }
}

