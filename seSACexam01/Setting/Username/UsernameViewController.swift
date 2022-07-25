//
//  UsernameViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class UsernameViewController: UIViewController {

    static let identifier = "UsernameViewController"
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = commonBackgroundColor()

        title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNewNickname))
        
        nicknameTextField.placeholder = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue)
    }
    
    ///function to save new nickname
    @objc func saveNewNickname() {
        let characterCount = nicknameTextField.text!.count
        switch characterCount {
        case 0, 1:
            showAlert(message: "2글자 이상 입력해주세요")
        case 2...6:
            UserDefaults.standard.set(nicknameTextField.text, forKey: UserDefaultsInfo.userNickname.rawValue)
            navigationController?.popViewController(animated: true)
        case 7...:
            showAlert(message: "최대 6글자까지 입력할 수 있습니다")
        default:
            showAlert(message: "올바르지 않은 숫자입니다")
        }
        
    }
    

}
