//
//  UsernameViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class UsernameViewController: UIViewController {

    static let identifier = "UsernameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
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
