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

        title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveUserNickname))
        
        nicknameTextField.placeholder = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue)
    }
    
    @objc func saveUserNickname() {
        if nicknameTextField.text!.count < 2 {
            showAlert(message: "2글자 이상 입력해주세요")
        } else {
            UserDefaults.standard.set(nicknameTextField.text, forKey: UserDefaultsInfo.userNickname.rawValue)
            navigationController?.popViewController(animated: true)            
        }
    }
    

}
