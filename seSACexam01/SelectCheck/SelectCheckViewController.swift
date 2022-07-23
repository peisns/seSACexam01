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
    @IBOutlet weak var selectedCharacterName: UILabel!
    @IBOutlet weak var selectedCharacterExplanation: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    let temporaryIndex = UserDefaults.standard.integer(forKey: UserDefaultsInfo.selectedCharacterIndexTemporary.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let characterdata = CharactersInfo().characters[temporaryIndex]
        selectedCharacterImage.image = UIImage(named: "\(temporaryIndex + 1)-6")
        selectedCharacterName.text = characterdata.name
        selectedCharacterExplanation.text = characterdata.introduction
        selectedCharacterExplanation.textAlignment = .center
        
        cancelButton.setTitle("취소", for: .normal)
        checkButton.setTitle("시작하기", for: .normal)
        
    }
    

    
     @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(temporaryIndex, forKey: UserDefaultsInfo.selectedCharacterIndexFixed.rawValue)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
    
    
}
