//
//  SelectCheckViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class SelectCheckViewController: UIViewController {
    
    static let identifier = "SelectCheckViewController"

    @IBOutlet weak var fullPopUpView: UIView!
    
    @IBOutlet weak var selectedCharacterImage: UIImageView!
    @IBOutlet weak var selectedCharacterNameButton: UIButton!
    @IBOutlet weak var middleLine: UIView!
    @IBOutlet weak var selectedCharacterExplanation: UITextView!
    
    @IBOutlet weak var buttonTopLine: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    let temporaryIndex = UserDefaults.standard.integer(forKey: UserDefaultsInfo.selectedCharacterIndexTemporary.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullPopUpView.backgroundColor = commonBackgroundColor()
        
        //show selected character image
        selectedCharacterImage.image = UIImage(named: "\(temporaryIndex + 1)-6")
        
        //show and design character name
        selectedCharacterNameButton.setTitle(CharactersInfo.characters[temporaryIndex].name, for: .normal)
        designCommonButtonStyle(buttonName: selectedCharacterNameButton)
        
        //design middle line
        middleLine.layer.borderColor = commonFontAndBorderColor().cgColor
        middleLine.layer.borderWidth = 1
        
        // show character explanation
        selectedCharacterExplanation.text = CharactersInfo.characters[temporaryIndex].introduction
        selectedCharacterExplanation.textAlignment = .center
        selectedCharacterExplanation.textColor = commonFontAndBorderColor()
        selectedCharacterExplanation.font = .systemFont(ofSize: 13)
        
        //design button Top line
        buttonTopLine.layer.borderWidth = 1
        buttonTopLine.layer.borderColor = UIColor.systemGray4.cgColor
        
        //design cancel button
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
        cancelButton.backgroundColor = .systemGray6
        
        //design start button
        if UserDefaults.standard.bool(forKey: UserDefaultsInfo.isCharacterSelected.rawValue) {
            checkButton.setTitle("변경하기", for: .normal)
        } else {
            checkButton.setTitle("시작하기", for: .normal)
        }
        checkButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
    }
    
     @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// function to save character index and change root view controller to Main scene
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        //save character index fixed
        UserDefaults.standard.set(temporaryIndex, forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
        
        //save if user selects character
        UserDefaults.standard.set(true, forKey: UserDefaultsInfo.isCharacterSelected.rawValue)
        
        //change root view controller to Main scene
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelete = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else {
            showAlert(message: "잘못된 스토리보드 입니다")
            return }
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelete?.window?.rootViewController = nav
        sceneDelete?.window?.makeKeyAndVisible()
    }
    
    
}
