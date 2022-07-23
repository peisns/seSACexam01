//
//  UIViewContorller+Extension.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import Foundation
import UIKit

extension UIViewController {
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
}
