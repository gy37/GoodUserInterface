//
//  BiZhiViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/11/28.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class BiZhiViewController: UIViewController {
    @IBOutlet var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension BiZhiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bizhiCell", for: indexPath) as! BiZhiCollectionViewCell
        if indexPath.row == 4 {
            cell.bgImageView.image = UIImage(named: "launch.jpg")
        }
        return cell
    }
}

extension BiZhiViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BiZhiCollectionViewCell
        if indexPath.row == 4 {
            // performSegue(withIdentifier: "showBiZhiDetail", sender: cell)
            navigationController?.setNavigationBarHidden(true, animated: true)
            let imageView = UIImageView(image: UIImage(named: "launch.jpg"))
            imageView.bounds = cell.bgImageView.bounds
            imageView.center = view.center
            view.addSubview(imageView)
            UIView.animate(withDuration: 0.5, animations: {
                imageView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }) { (finish) in
                let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bizhiDetail") as! BiZhiDetailViewController
                detail.setNeedsStatusBarAppearanceUpdate()
                self.addChildViewController(detail)
                self.view.addSubview(detail.view)
                detail.didScroll = { (offset) in

                    if (offset <= 0) {
                        if offset == -100 {
                            detail.view.removeFromSuperview()
                            detail.removeFromParentViewController()
                            self.navigationController?.setNavigationBarHidden(false, animated: false)
                        }
                        if imageView.bounds.height <= 5 {
                            imageView.removeFromSuperview()
                        } else {
                            let scale = 1 - abs(offset / 100)
                            if scale == 1 {
                                imageView.removeFromSuperview()
                            }
                            imageView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * scale, height: UIScreen.main.bounds.height * scale)
                        }
                    }
                }
            }
        }
    }
}
