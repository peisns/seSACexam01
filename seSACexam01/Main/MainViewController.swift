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
    
    @IBOutlet var mealAndWaterTextFieldCollection: [UITextField]!
    
    @IBOutlet var mealAndWaterButtonCollection: [UIButton]!
    
    let characterIndex: Int = UserDefaults.standard.integer(forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
    
    var userNickname = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue) ?? "대장"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = commonBackgroundColor()
        
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
        characterNameButton.isEnabled = false
        designCommonButtonStyle(buttonName: characterNameButton)
        
        //design character exp
        characterExpLabel.textAlignment = .center
        characterExpLabel.textColor = commonFontAndBorderColor()
        characterExpLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        //design meal and water button
        var buttonTag = 0
        for button in mealAndWaterButtonCollection {
            button.tintColor = commonFontAndBorderColor()
            button.tag = buttonTag
            designCommonButtonStyle(buttonName: button)
            buttonTag += 1
        }
        mealAndWaterButtonCollection[0].setTitle("밥먹기", for: .normal)
        mealAndWaterButtonCollection[0].setImage(UIImage(systemName: "drop.circle"), for: .normal)
        mealAndWaterButtonCollection[1].setTitle("물먹기", for: .normal)
        mealAndWaterButtonCollection[1].setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        
        // design meal and water text field
        for textField in mealAndWaterTextFieldCollection {
            textField.textAlignment = .center
            textField.font = .systemFont(ofSize: 13)
            textField.keyboardType = .numberPad
        }
        mealTextField.placeholder = "밥주세용"
        waterTextField.placeholder = "물주세용"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //show and change userNickname
        userNickname = UserDefaults.standard.string(forKey: UserDefaultsInfo.userNickname.rawValue) ?? "대장"
        title = "\(userNickname)님의 다마고치"
        
        //change navigation bar title color
        let textAttributes = [NSAttributedString.Key.foregroundColor:commonFontAndBorderColor()]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //show Character Exp and words in Label
        updateCharacterExpAndWordsLabel()
        
    }
    
    ///navigation right bar button(push to setting storyboard) clicked
    @IBAction func settingButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///remove non-digit
    @IBAction func textConvertToDigit(_ sender: UITextField) {
        let convertDigit = sender.text!.replacingOccurrences(of: #"\D"#, with: "", options: .regularExpression)
        sender.text = convertDigit
    }
    
    ///add meal and water count when text is returned
    @IBAction func mealAndWaterTextFieldReturn(_ sender: UITextField) {
        addMealAndWaterCount(foodType: FoodType.allCases[sender.tag])
    }
    
    ///add meal and water count when button is clicked
    @IBAction func mealAndWaterButtonClicked(_ sender: UIButton) {
        addMealAndWaterCount(foodType: FoodType.allCases[sender.tag])
        view.endEditing(true)
    }
   
    ///function to add meal and water count
    func addMealAndWaterCount(foodType:FoodType) {
        switch foodType {
        case FoodType.meal: // user clicked meal button
            countCheck(textFieldName: mealTextField, userDefaultsRawValue: UserDefaultsInfo.characterMealCount.rawValue, maxNumber: 99, targetNameOfCount: "밥")
        case FoodType.water: // user clicked water button
            countCheck(textFieldName: waterTextField, userDefaultsRawValue: UserDefaultsInfo.characterWaterCount.rawValue, maxNumber: 49, targetNameOfCount: "물")
        }
    }
    
    /// user info calculator
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
    
    /// function to check that the count is valid
    func countCheck(textFieldName:UITextField, userDefaultsRawValue:String, maxNumber:Int, targetNameOfCount:String) {
        var newCount = Int()
        if textFieldName.text!.isEmpty { // text is empty
            newCount = UserDefaults.standard.integer(forKey: userDefaultsRawValue) + 1
            UserDefaults.standard.set(newCount, forKey: userDefaultsRawValue)
            updateCharacterExpAndWordsLabel()
        } else {  // text is valid
            let inputCount = Int(textFieldName.text!) ?? 0
            textFieldName.text = "" // clear text field
            switch inputCount {
            case 0...maxNumber: // count
                newCount = UserDefaults.standard.integer(forKey: userDefaultsRawValue) + inputCount
                UserDefaults.standard.set(newCount, forKey: userDefaultsRawValue)
                updateCharacterExpAndWordsLabel()
            case (maxNumber + 1)...: // alert because the number is too big
                showAlert(message: "\(targetNameOfCount)을 \(maxNumber + 1) 이상 줄 수 없어요")
            default: // alert because wrong number is inputted
                showAlert(message: "잘못된 숫자입니다")
            }
        }
    }
}
