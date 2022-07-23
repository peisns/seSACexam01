//
//  SettingTableViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"
    
    
    @IBOutlet var cellImageCollection: [UIImageView]!
    @IBOutlet var cellTitleCollection: [UILabel]!
    @IBOutlet weak var myNicknameDetailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellImageCollection[0].image = UIImage(systemName: "pencil")
        cellImageCollection[1].image = UIImage(systemName: "moon.fill")
        cellImageCollection[2].image = UIImage(systemName: "arrow.clockwise")
        for image in cellImageCollection {
            image.tintColor = commonFontAndBorderColor()
        }
        
        cellTitleCollection[0].text = "내 이름 설정하기"
        cellTitleCollection[1].text = "다마고치 변경하기"
        cellTitleCollection[2].text = "데이터 초기화"
        title = "설정"
        
        
        
        myNicknameDetailLabel.text = "대장"
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "Username", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: UsernameViewController.identifier) as? UsernameViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
            navigationController?.pushViewController(vc, animated: true)

        default:
            showAlert(message: "준비중")
            return
        }
    }
}
