//
//  CollectionViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit

class CollectionViewController: UICollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        collectionView.backgroundColor = .white
        // переиспользование ячеек, чтобы уплывающие освобождали память
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Indentifiers.collectionViewCell)
        NetworkService().getPhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Indentifiers.collectionViewCell, for: indexPath)
        // проверим, является ли наша ячейка нашей кастомной ячейкой и обратимся к ней как к кастомной
        guard let cell = cell as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.tap = { [weak self] image in self?.navigationController?.pushViewController(ImageViewController(image: image), animated: true)}
        return cell
    }
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width/2.1, height: view.frame.size.width/2.8)
        //CGSize(width: 200, height: 200)
    }
}
