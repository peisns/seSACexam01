//
//  UIViewContorller+Extension.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    ///function to present a short alert
    func showAlert(title: String = "알림", message: String, style: UIAlertController.Style = .alert, okButtonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func commonBackgroundColor() -> UIColor {
        return UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    }

    func commonFontAndBorderColor() -> UIColor {
        return UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    }
    
    ///design Common Button style
    func designCommonButtonStyle(buttonName: UIButton) {
        buttonName.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        buttonName.setTitleColor(commonFontAndBorderColor(), for: .normal)
        buttonName.layer.borderWidth = 1
        buttonName.layer.borderColor = commonFontAndBorderColor().cgColor
        buttonName.layer.cornerRadius = 5
    }
}
