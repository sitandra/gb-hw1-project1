//
//  ProfileViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

import UIKit

class ProfileViewController: UIViewController, ThemeViewDelegate {
    private var networkService = NetworkService()
    private var model: ProfileModel? = nil
    
    private var themeView = ThemeView()
    private var isUserProfile: Bool
    
    init(name: String? = nil, photo: UIImage? = nil, isUserProfile: Bool) {
        self.isUserProfile = isUserProfile
        super.init(nibName: nil, bundle: nil)
        self.name.text = name
        self.avatar.image = photo
        themeView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        self.title = "Profile"
        setupViews()
        if isUserProfile {
            networkService.getProfile { [weak self] model in
                DispatchQueue.main.async {
                    self?.name.text = model.response.firstName + " " + model.response.lastName
                    self?.networkService.getPhoto(imageURL: model.response.photo) { [weak self] imgData in
                        guard let image = UIImage(data: imgData) else {return}
                        DispatchQueue.main.async {
                            self?.avatar.image = image
                        }
                    }
                }
            }
        } else {
            themeView.isHidden = true
        }
    }
    
    func updateColor() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    private var avatar: UIImageView = {
        let logo = UIImageView(image: UIImage())
        logo.sizeToFit()
        return logo
    }()
    
    private var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemOrange
        label.text = "Name"
        return label
    }()
    
    
    
    private func setupViews() {
        view.addSubview(avatar)
        view.addSubview(name)
        view.addSubview(themeView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        avatar.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        themeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            avatar.heightAnchor.constraint(equalToConstant: view.frame.size.width/2),
            
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.heightAnchor.constraint(equalToConstant: view.frame.size.width/8),
            
            themeView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 40),
            themeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            themeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            themeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }

}
