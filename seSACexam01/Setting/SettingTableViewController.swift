//
//  SettingTableViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"
    
    @IBOutlet var mainTableView: UITableView!
    
    @IBOutlet var mainTableViewCell: [UITableViewCell]!
    
    @IBOutlet var cellImageCollection: [UIImageView]!
    @IBOutlet var cellTitleCollection: [UILabel]!
    @IBOutlet weak var myNicknameDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background color
        view.backgroundColor = commonBackgroundColor()
        for cell in mainTableViewCell {
            cell.backgroundColor = commonBackgroundColor()
        }
        
        var cellImageIndex: Int = 0
        for cell in cellImageCollection {
            cell.image = UIImage(systemName: SettingValues.settingValues[cellImageIndex].image)
            cell.tintColor = commonFontAndBorderColor()
            cellImageIndex += 1
        }
        
        var cellTitleIndex: Int = 0
        for cell in cellTitleCollection {
            cell.text = SettingValues.settingValues[cellTitleIndex].title
            cellTitleIndex += 1
        }
        
        title = "설정"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // show Nickname
        myNicknameDetailLabel.text = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingValues.settingValues.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingTitle.allCases[indexPath.row] {
        //push to Username scene to change nickname
        case .updateMyNickname:
            let sb = UIStoryboard(name: "Username", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: UsernameViewController.identifier) as? UsernameViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
            navigationController?.pushViewController(vc, animated: true)
            
        //push to Select scene to change character
        case .updateCharacter:
            let sb = UIStoryboard(name: "Select", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectCollectionViewController.identifier) as? SelectCollectionViewController else {
                showAlert(message: "잘못된 스토리보드입니다")
                return }
            navigationController?.pushViewController(vc, animated: true)
            
        //present alert to check data reset process
        case .resetData:
            let alert = UIAlertController(title: "중요", message: "데이터를 초기화하시겠습니까?\n초기화를 실행하면 데이터를 복구할 수 없습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){(_) in
                self.resetData()
            }
            let cancel = UIAlertAction(title: "취소", style: .destructive)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
            return }
    }
    
    /// function to reset data and change root view controller to select scene
    func resetData() {
        //reset UserDefaults value
        UserDefaults.standard.set("대장", forKey: UserDefaultsInfo.userNickname.rawValue)
        UserDefaults.standard.set(0, forKey: UserDefaultsInfo.characterMealCount.rawValue)
        UserDefaults.standard.set(0, forKey: UserDefaultsInfo.characterWaterCount.rawValue)
        UserDefaults.standard.set(false, forKey: UserDefaultsInfo.isCharacterSelected.rawValue)
        
        //change root view controller to Select scene
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
