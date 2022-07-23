//
//  MainViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"

    @IBOutlet weak var rightBarButtonToSetting: UIBarButtonItem!
    
    @IBOutlet weak var characterWordBackImage: UIImageView!
    @IBOutlet weak var characterWordTextLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterExpLabel: UILabel!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet var mealAndWaterButtonCollection: [UIButton]!
    
    let characterIndex: Int = UserDefaults.standard.integer(forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "대장님의 다마고치"
        
        rightBarButtonToSetting.image = UIImage(systemName: "person.circle")
//        rightBarButtonToSetting.tintColor = commonFontAndBorderColor()
        self.navigationController?.navigationBar.tintColor = commonFontAndBorderColor()
        
        characterWordBackImage.image = UIImage(named: "bubble")
        
        characterWordTextLabel.text = CharactersInfo.words[Int.random(in: 1...CharactersInfo.words.count) - 1]
        characterWordTextLabel.textAlignment = .center
        
        let mealCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterMealCount.rawValue)
        let waterCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterWaterCount.rawValue)
        let userInfo:UserInfo = calculateUserInfo(mealCount: mealCount, waterCount: waterCount, characterIndex: characterIndex)
        characterImage.image = UIImage(named: userInfo.image)
        
        characterNameLabel.text = CharactersInfo.characters[characterIndex].name
        characterNameLabel.textAlignment = .center
        
        characterExpLabel.text = "LV\(String(userInfo.level)) • 밥알 \(mealCount)개 • 물방울 \(waterCount)개"
        
        for button in mealAndWaterButtonCollection {
            button.layer.borderColor = commonFontAndBorderColor().cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 3
            button.setTitleColor(commonFontAndBorderColor(), for: .normal)
            button.tintColor = commonFontAndBorderColor()
        }
        mealAndWaterButtonCollection[0].setTitle("밥먹기", for: .normal)
        mealAndWaterButtonCollection[0].setImage(UIImage(systemName: "drop.circle"), for: .normal)
        mealAndWaterButtonCollection[1].setTitle("물먹기", for: .normal)
        mealAndWaterButtonCollection[1].setImage(UIImage(systemName: "leaf.circle"), for: .normal)

    }
    
    @IBAction func settingButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func calculateUserInfo(mealCount:Int, waterCount:Int, characterIndex: Int) -> UserInfo {
        let totalExp:Double = (Double(mealCount) / 5) + (Double(waterCount) / 2)
        let level = Int(floor(totalExp) / 10)
        let stringCharacterIndex = String(characterIndex + 1)
        
        switch totalExp {
        case 0..<10:
            return UserInfo(level: 1, image: stringCharacterIndex + "-1")
        case 10..<20:
            return UserInfo(level: 1, image: stringCharacterIndex + "-1")
        case 20..<100:
            return UserInfo(level: level, image: stringCharacterIndex + "-" + String(level))
        default:
            return UserInfo(level: level, image: stringCharacterIndex + "-9")
        }
    }

}
