//
//  BiZhiDetailViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/11/28.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class BiZhiDetailViewController: UIViewController {

    @IBOutlet var detailCollectionView: UICollectionView!
    var didScroll: ((_ offset: CGFloat) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BiZhiDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bizhiCell", for: indexPath) as! BiZhiCollectionViewCell
        if indexPath.row == 1 {
            cell.bgImageView.image = UIImage(named: "launch.jpg")
        } else {
            cell.bgImageView.image = nil
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "bizhiHeader", for: indexPath) as! BiZhiCollectionHeaderView
            header.imageView.image = UIImage(named: "launch.jpg")
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension BiZhiDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else {
            return CGSize.zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}

extension BiZhiDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        print(offset)
        if offset <= 0 {
            view.alpha = 0.01
            if let scrollClosure = didScroll {
                scrollClosure(offset)
            }
        } else {
            view.alpha = 1
        }
    }
}


