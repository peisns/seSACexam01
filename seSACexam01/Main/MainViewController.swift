//
//  MainViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/23.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"

    @IBOutlet weak var characterWordBackImage: UIImageView!
    @IBOutlet weak var characterWordTextLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterExpLabel: UILabel!
    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet var mealAndWaterButtonCollection: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "대장님의 다마고치"
        
        characterWordBackImage.image = UIImage(named: "bubble")

    }
    
    @IBAction func settingButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            showAlert(message: "잘못된 스토리보드입니다")
            return }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
