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
    }
    
    @objc func saveUserNickname() {
        UserDefaults.standard.set(nicknameTextField.text, forKey: UserDefaultsInfo.userNickname.rawValue)
        navigationController?.popViewController(animated: true)
    }
    

}
