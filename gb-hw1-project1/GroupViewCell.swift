//
//  GroupViewCell.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 19.08.2023.
//

import UIKit

class GroupViewCell: UITableViewCell
{
    private var photo: UIImageView = {
        let circle = UIImageView(image: UIImage(systemName: "person"))
        circle.backgroundColor = .systemGray
        circle.layer.cornerRadius = Constants.Views.Icon.width / 2
        circle.clipsToBounds = true
        //logo.sizeToFit()
        return circle
    }()
    
    private var groupName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        return label
    }()
    
    private var groupDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(group: GroupModel.GroupResponse.UserGroup?) {
        groupName.text = group?.name ?? "Name"
        groupDescription.text = group?.description ?? "Description"
    }
    
    func setupImage(image: UIImage?) {
        self.photo.image = image
    }
    
    private func setupViews(){
        contentView.addSubview(photo)
        contentView.addSubview(groupName)
        contentView.addSubview(groupDescription)
        setupConstraints()
    }
    
    private func setupConstraints() {
        photo.translatesAutoresizingMaskIntoConstraints = false
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupDescription.translatesAutoresizingMaskIntoConstraints = false
        // чтобы ячейка подстраивалась под контент, нужно один элемент прицепить к верхней границе, а второй к нижней, иначе ячейка схлопнется...
        NSLayoutConstraint.activate([
            //circle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photo.heightAnchor.constraint(equalToConstant: Constants.Views.Icon.width),
            photo.widthAnchor.constraint(equalTo: photo.heightAnchor),
            
            groupName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupName.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 10),
            groupName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            groupDescription.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 10),
            groupDescription.leadingAnchor.constraint(equalTo: groupName.leadingAnchor),
            groupDescription.trailingAnchor.constraint(equalTo: groupName.trailingAnchor),
            groupDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupName.text = nil
        groupDescription.text = nil
    }
}
