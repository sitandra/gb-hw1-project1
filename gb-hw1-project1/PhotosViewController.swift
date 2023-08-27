//
//  CollectionViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit

class PhotosViewController: UICollectionViewController{
    private var networkService = NetworkService()
    private var model: PhotoModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        // переиспользование ячеек, чтобы уплывающие освобождали память
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: Constants.Indentifiers.photoViewCell)
        networkService.getPhotos { [weak self] photos in
            self?.model = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        collectionView.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.response.items.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Indentifiers.photoViewCell, for: indexPath)
        // проверим, является ли наша ячейка нашей кастомной ячейкой и обратимся к ней как к кастомной
        guard let cell = cell as? PhotoViewCell else {
            return UICollectionViewCell()
        }
        cell.tap = { [weak self] image in
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.type = .fade
            animation.duration = 1
            self?.navigationController?.view.layer.add(animation,  forKey: nil)
            self?.navigationController?.pushViewController(PhotoViewController(image: image), animated: false)
            
        }
        let model = model?.response.items[indexPath.row]
        
        networkService.getPhoto(imageURL: model?.sizes.last?.url) { [weak cell] imgData in
            guard let image = UIImage(data: imgData) else {return}
            DispatchQueue.main.async {
                cell?.setupImage(image: image)
            }
        }
        return cell
    }
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width/2.1, height: view.frame.size.width/2.8)
        //CGSize(width: 200, height: 200)
    }
}
