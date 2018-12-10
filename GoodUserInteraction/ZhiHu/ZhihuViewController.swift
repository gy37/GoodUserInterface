//
//  ZhihuViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/7/27.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class ZhihuViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var contentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTableView.backgroundView = UIImageView(image: UIImage(named: "launch.jpg"))
    }
    
    
}

extension ZhihuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath)
        cell.textLabel?.text = "cell---\(indexPath.row)"
        if indexPath.row == 4 {
            cell.backgroundColor = .clear
            for subview in cell.subviews {
                subview.backgroundColor = .clear
            }
        }
        return cell
    }
    
}

extension ZhihuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
