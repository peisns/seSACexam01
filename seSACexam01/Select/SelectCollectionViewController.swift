//
//  SelectCollectionViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/22.
//

import UIKit

class SelectCollectionViewController: UICollectionViewController {
    
    static let identifier = "SelectCollectionViewController"

    let cellCount = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "다마고치 선택하기"
                
        collectionView.backgroundColor = commonBackgroundColor()
        
        let cellLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width - (spacing * 4 + 1)
        cellLayout.itemSize = CGSize(width: screenWidth / 3 , height: (screenWidth / 3) * 1.2)
        cellLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        cellLayout.minimumLineSpacing = spacing
        cellLayout.minimumInteritemSpacing = spacing

        collectionView.collectionViewLayout = cellLayout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.characterNameButton.titleLabel?.font = .systemFont(ofSize: 13)
        cell.characterNameButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        cell.characterNameButton.isEnabled = false
        cell.characterNameButton.setTitleColor(commonFontAndBorderColor(), for: .normal)
        cell.characterNameButton.layer.borderWidth = 1
        cell.characterNameButton.layer.borderColor = commonFontAndBorderColor().cgColor
        cell.characterNameButton.layer.cornerRadius = 5
//        cell.characterNameButton.sizeToFit()
        
        switch indexPath.row {
        case 0..<CharactersInfo.characters.count:
            cell.characterNameButton.setTitle(CharactersInfo.characters[indexPath.row].name, for: .normal)
            cell.characterImage.image = UIImage(named: "\(indexPath.row + 1)-6")
        default:
            cell.characterNameButton.setTitle("준비중이에요", for: .normal)
            cell.characterImage.image = UIImage(named: "noImage")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //UserDefaults에 캐릭터List중에 임시로 선택한 캐릭터 저장
        
        if indexPath.row < CharactersInfo.characters.count {
            UserDefaults.standard.set(indexPath.row, forKey: UserDefaultsInfo.selectedCharacterIndexTemporary.rawValue)
            let sb = UIStoryboard(name: "SelectCheck", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectCheckViewController.identifier) as? SelectCheckViewController else {
                showAlert(message: "잘못된 스토리보드입니다.")
                return }
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        } else {
            showAlert(message: "아직 준비중입니다")
        }
    }
}
