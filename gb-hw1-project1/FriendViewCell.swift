//
//  CustomTableViewCell.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit

class FriendViewCell: UITableViewCell
{
    var tap: ((String?, UIImage?) -> Void)?
    
    private var photo: UIImageView = {
        let circle = UIImageView(image: UIImage(systemName: "person"))
        circle.backgroundColor = .systemGray
        circle.layer.cornerRadius = Constants.Views.Icon.width / 2
        circle.clipsToBounds = true
        return circle
    }()
    
    private var friendName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        return label
    }()
    
    private var onlineCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = Constants.Views.Detector.offlineColor
        circle.layer.cornerRadius = Constants.Views.Detector.width / 2
        return circle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        addGestureRecognizer(recognizer)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(friend: FriendModel.FriendResponse.Friend?) {
        friendName.text = (friend?.firstName ?? "firstName") + " " + (friend?.lastName ?? "lastName")
        onlineCircle.backgroundColor = friend?.isOnline == 1 ? Constants.Views.Detector.onlineColor : Constants.Views.Detector.offlineColor
    }
    
    func setupImage(image: UIImage?) {
        self.photo.image = image
    }
    
    private func setupViews(){
        contentView.addSubview(photo)
        contentView.addSubview(onlineCircle)
        contentView.addSubview(friendName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        photo.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        onlineCircle.translatesAutoresizingMaskIntoConstraints = false
        // чтобы ячейка подстраивалась под контент, нужно один элемент прицепить к верхней границе, а второй к нижней, иначе ячейка схлопнется...
        NSLayoutConstraint.activate([
            photo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photo.heightAnchor.constraint(equalToConstant: Constants.Views.Icon.width),
            photo.widthAnchor.constraint(equalTo: photo.heightAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            friendName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            friendName.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 30),
            friendName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            onlineCircle.topAnchor.constraint(equalTo: photo.topAnchor),
            onlineCircle.leadingAnchor.constraint(equalTo: photo.trailingAnchor),
            onlineCircle.heightAnchor.constraint(equalToConstant: Constants.Views.Detector.width),
            onlineCircle.widthAnchor.constraint(equalTo: onlineCircle.heightAnchor),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendName.text = nil
    }
    
    @objc func cellTap() {
        tap?(friendName.text, photo.image)
    }
}
