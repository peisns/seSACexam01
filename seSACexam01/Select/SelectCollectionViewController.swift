//
//  SelectCollectionViewController.swift
//  seSACexam01
//
//  Created by Brother Model on 2022/07/22.
//

import UIKit

class SelectCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "다마고치 선택하기"
        
        let cellLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width - 100
        cellLayout.itemSize = CGSize(width: screenWidth / 3 , height: (screenWidth / 3) * 1.2)
        cellLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        cellLayout.minimumLineSpacing = spacing
        cellLayout.minimumInteritemSpacing = spacing

        collectionView.collectionViewLayout = cellLayout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }

}
