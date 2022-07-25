//
//  SelectCheckViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class SelectCheckViewController: UIViewController {
    
    static let identifier = "SelectCheckViewController"

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
        
        //show selected character image
        selectedCharacterImage.image = UIImage(named: "\(temporaryIndex + 1)-6")
        
        //show and design character name
        selectedCharacterNameButton.setTitle(CharactersInfo.characters[temporaryIndex].name, for: .normal)
        selectedCharacterNameButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
        selectedCharacterNameButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        selectedCharacterNameButton.layer.borderColor = commonFontAndBorderColor().cgColor
        selectedCharacterNameButton.layer.borderWidth = 1
        selectedCharacterNameButton.layer.cornerRadius = 5
        
        //design middle line
        middleLine.layer.borderColor = commonFontAndBorderColor().cgColor
        middleLine.layer.borderWidth = 1
        
        // show choaracter explanation
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
        checkButton.setTitle("시작하기", for: .normal)
        checkButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
        
    }
    

    
     @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(temporaryIndex, forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
        UserDefaults.standard.set(true, forKey: UserDefaultsInfo.isCharacterSelected.rawValue)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
    
    
}
