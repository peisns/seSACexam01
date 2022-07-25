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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        myNicknameDetailLabel.text = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue)
    
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
        case 1:
            let sb = UIStoryboard(name: "Select", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectCollectionViewController.identifier) as? SelectCollectionViewController else {
                showAlert(message: "잘못된 스토리보드입니다")
                return }
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let alert = UIAlertController(title: "중요", message: "데이터를 초기화하시겠습니까?\n초기화를 실행하면 데이터를 복구할 수 없습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){(_) in
                self.resetData()
            }
            let cancel = UIAlertAction(title: "취소", style: .destructive)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
            return
        default:
            showAlert(message: "준비중")
            return
        }
    }
    
    func resetData() {
        UserDefaults.standard.set("대장", forKey: UserDefaultsInfo.userNickname.rawValue)
        UserDefaults.standard.set(0, forKey: UserDefaultsInfo.characterMealCount.rawValue)
        UserDefaults.standard.set(0, forKey: UserDefaultsInfo.characterWaterCount.rawValue)
        UserDefaults.standard.set(false, forKey: UserDefaultsInfo.isCharacterSelected.rawValue)
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate

        let sb = UIStoryboard(name: "Select", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SelectCollectionViewController.identifier) as? SelectCollectionViewController else {
        showAlert(message: "잘못된 스토리보드입니다")
        return }
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
