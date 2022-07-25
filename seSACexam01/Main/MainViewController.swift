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
    
    @IBOutlet weak var topLine: UIView!
    
    
    @IBOutlet weak var characterWordBackImage: UIImageView!
    @IBOutlet weak var characterWordTextLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameButton: UIButton!
    @IBOutlet weak var characterExpLabel: UILabel!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet var mealAndWaterButtonCollection: [UIButton]!
    
    let characterIndex: Int = UserDefaults.standard.integer(forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
    
    var userNickname = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue) ?? "대장"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //place top line
        topLine.layer.borderWidth = 1
        topLine.layer.borderColor = UIColor.systemGray4.cgColor
        
        //create navigation right button
        rightBarButtonToSetting.image = UIImage(systemName: "person.circle")
        self.navigationController?.navigationBar.tintColor = commonFontAndBorderColor()
        
        //set word's back image
        characterWordBackImage.image = UIImage(named: "bubble")
        
        //set random word alignment
        characterWordTextLabel.textAlignment = .center
        characterWordTextLabel.textColor = commonFontAndBorderColor()
        characterWordTextLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        //design character name
        characterNameButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
        characterNameButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        characterNameButton.layer.borderColor = commonFontAndBorderColor().cgColor
        characterNameButton.layer.borderWidth = 1
        characterNameButton.layer.cornerRadius = 5
        characterNameButton.isEnabled = false
        
        //design character exp
        characterExpLabel.textAlignment = .center
        characterExpLabel.textColor = commonFontAndBorderColor()
        characterExpLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        //design meal and water button
        var buttonTag = 0
        for button in mealAndWaterButtonCollection {
            button.layer.borderColor = commonFontAndBorderColor().cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.setTitleColor(commonFontAndBorderColor(), for: .normal)
            button.tintColor = commonFontAndBorderColor()
            button.tag = buttonTag
            buttonTag += 1
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        }
        mealAndWaterButtonCollection[0].setTitle("밥먹기", for: .normal)
        mealAndWaterButtonCollection[0].setImage(UIImage(systemName: "drop.circle"), for: .normal)
        mealAndWaterButtonCollection[1].setTitle("물먹기", for: .normal)
        mealAndWaterButtonCollection[1].setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        
        mealTextField.placeholder = "밥주세용"
        mealTextField.textAlignment = .center
        mealTextField.font = .systemFont(ofSize: 13)
        mealTextField.keyboardType = .numberPad
        waterTextField.placeholder = "물주세용"
        waterTextField.textAlignment = .center
        waterTextField.font = .systemFont(ofSize: 13)
        waterTextField.keyboardType = .numberPad
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //show and change userNickname
        userNickname = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue) ?? "대장"
        title = "\(userNickname)님의 다마고치"
        let textAttributes = [NSAttributedString.Key.foregroundColor:commonFontAndBorderColor()]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //show Character Exp and words in Label
        updateCharacterExpAndWordsLabel()
        
    }
    
    //navigation right bar button(to setting storyboard) clicked
    @IBAction func settingButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func mealAndWaterTextFieldReturn(_ sender: UITextField) {
        addMealAndWaterCount(senderTag: sender.tag)
    }
    
    
    @IBAction func mealAndWaterButtonClicked(_ sender: UIButton) {
        addMealAndWaterCount(senderTag: sender.tag)
        view.endEditing(true)
    }
   
    
    func addMealAndWaterCount(senderTag:Int) {
        switch senderTag {
        case 0: // user clicked meal button
            var newMealCount = Int()
            if mealTextField.text!.isEmpty { // text is empty
                newMealCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterMealCount.rawValue) + 1
                UserDefaults.standard.set(newMealCount, forKey: UserDefaultsInfo.characterMealCount.rawValue)
                updateCharacterExpAndWordsLabel()
            } else {  // text is valid
                let inputCount = Int(mealTextField.text!) ?? 0
                mealTextField.text = "" // clear text field
                switch inputCount {
                case 0...99: // feed
                    newMealCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterMealCount.rawValue) + inputCount
                    UserDefaults.standard.set(newMealCount, forKey: UserDefaultsInfo.characterMealCount.rawValue)
                    updateCharacterExpAndWordsLabel()
                case 100...: // alert because the number is too big
                    showAlert(message: "밥을 100 이상 줄 수 없어요")
                default: // alert because wrong number is inputted
                    showAlert(message: "잘못된 숫자입니다")
                }
            }
        case 1: // user clicked water button
            var newWaterCount = Int()
            if waterTextField.text!.isEmpty { // text is empty
                newWaterCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterWaterCount.rawValue) + 1
                UserDefaults.standard.set(newWaterCount, forKey: UserDefaultsInfo.characterWaterCount.rawValue)
                updateCharacterExpAndWordsLabel()
            } else {
                let inputCount = Int(waterTextField.text!) ?? 0 // text is vaild
                waterTextField.text = "" // clear text field
                switch inputCount {
                case 0...99: // feed
                    newWaterCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterWaterCount.rawValue) + inputCount
                    UserDefaults.standard.set(newWaterCount, forKey: UserDefaultsInfo.characterWaterCount.rawValue)
                    updateCharacterExpAndWordsLabel()
                case 100...: // alert because the number is too big
                    showAlert(message: "밥을 100 이상 줄 수 없어요")
                default: // alert because wrong number is inputted
                    showAlert(message: "잘못된 숫자입니다")
                }
            }
        default:
            showAlert(message: "오류가 발생했습니다(mealAndWaterButton")
        }
    }
    
    
    // present user info calculator
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
        case 100...:
            return UserInfo(level: 10, image: stringCharacterIndex + "-9")
        default:
            showAlert(message: "오류가 발생했습니다(from level calculater)")
            return UserInfo(level: 0, image: stringCharacterIndex + "-1")
        }
    }
    
    func updateCharacterExpAndWordsLabel() {
        //load meal and water count
        let mealCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterMealCount.rawValue)
        let waterCount = UserDefaults.standard.integer(forKey: UserDefaultsInfo.characterWaterCount.rawValue)
        
        //declaration userInfo(after load meal and water count)
        let userInfo:UserInfo = calculateUserInfo(mealCount: mealCount, waterCount: waterCount, characterIndex: characterIndex)
        
        //show random words
        if userInfo.level == 10 {
            characterWordTextLabel.text = CharactersInfo.finalWord
        } else {
            let wordsCountMaxIndex = CharactersInfo.words.count - 1
            characterWordTextLabel.text = CharactersInfo.words[Int.random(in: 0...wordsCountMaxIndex)]
        }
        //show character Image
        characterImage.image = UIImage(named: userInfo.image)
        
        //show character name
        characterNameButton.setTitle(CharactersInfo.characters[characterIndex].name, for: .normal)
        
        //show character Exp
        characterExpLabel.text = "LV\(userInfo.level) • 밥알 \(mealCount)개 • 물방울 \(waterCount)개"
    }
}

