
//
//  OneTimePickerViewController.swift
//  GoodUserInteraction
//
//  Created by smarfid on 2018/6/13.
//  Copyright © 2018 smarfid. All rights reserved.
//

import UIKit

class OneTimePickerViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var bottomScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Time Picker"
        bottomScrollView.contentSize = CGSize(width: MyConfigation.ScreenWidth * 7, height: bottomScrollView.frame.size.height * 7)
        picker.delegate = self as UIPickerViewDelegate
        picker.dataSource = self as UIPickerViewDataSource
    }

    
}

extension OneTimePickerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let timeInterval = TimeInterval(scrollView.contentOffset.x / scrollView.frame.size.width * 60 * 60 * 24)
        datePicker.setDate(Date.init(timeIntervalSinceNow: timeInterval), animated: true)
        let row = scrollView.contentOffset.y / scrollView.frame.size.height
        picker.selectRow(Int(row), inComponent: 0, animated: true)
    }
}

extension OneTimePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
}

extension OneTimePickerViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel: UILabel!
        if let label = view as? UILabel {
            pickerLabel = label
        } else {
            pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: MyConfigation.ScreenWidth / 3.0, height: 30))
            pickerLabel.textAlignment = .center
        }
        let string = String(format: "%02d", component) + "区，" + String(format: "%02d", row) + "行"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], range: NSRange(location: 0, length: string.count))
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)], range: NSRange(location: 0, length: 2))
        pickerLabel.attributedText = attributedString
        return pickerLabel
    }
}
