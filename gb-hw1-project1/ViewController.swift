//
//  ViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 05.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupViews()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    private var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(systemName: "person"))
        //logo.sizeToFit()
        return logo
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemOrange
        label.text = "Авторизация"
        return label
    }()
    
    private var inputLogin: UITextField = {
        let input = UITextField()
        input.textAlignment = .left
        input.borderStyle = .line
        input.tintColor = .systemBlue
        input.placeholder = "Логин"
        let spacerView = UIView(frame: CGRect(x:0,y:0,width:10,height:10))
        input.leftViewMode = .always
        input.leftView = spacerView
        input.rightViewMode = .always
        input.rightView = spacerView
        return input
    }()
    
    private var inputPass: UITextField = {
        let input = UITextField()
        input.textAlignment = .left
        input.borderStyle = .line
        input.tintColor = .systemBlue
        input.placeholder = "Пароль"
        input.isSecureTextEntry = true
        let spacerView = UIView(frame: CGRect(x:0,y:0,width:10,height:10))
        input.leftViewMode = .always
        input.leftView = spacerView
        input.rightViewMode = .always
        input.rightView = spacerView
        return input
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.systemOrange, for: .highlighted)
        return button
    }()
    
    private func setupViews() {
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(inputLogin)
        view.addSubview(inputPass)
        view.addSubview(button)
        setupConstraints()
    }
    
    private func setupConstraints(){
        logo.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        inputLogin.translatesAutoresizingMaskIntoConstraints = false
        inputPass.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            logo.heightAnchor.constraint(equalToConstant: view.frame.size.width/2),
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: view.frame.size.width/8),
            
            inputLogin.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            inputLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/5),
            inputLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/5),
            inputLogin.heightAnchor.constraint(equalToConstant: view.frame.size.width/10),
            
            inputPass.topAnchor.constraint(equalTo: inputLogin.bottomAnchor, constant: 10),
            inputPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputPass.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/5),
            inputPass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/5),
            inputPass.heightAnchor.constraint(equalToConstant: view.frame.size.width/10),
            
            button.topAnchor.constraint(equalTo: inputPass.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/10),
            button.heightAnchor.constraint(equalToConstant: view.frame.size.width/5)
        ])
    }
}

private extension ViewController {
    @objc func tap() {
        let FriendsViewController = UINavigationController(rootViewController: TableViewController())
        let GroupsViewController = UINavigationController(rootViewController: TableViewController2())
        let PhotosViewController = UINavigationController(rootViewController: CollectionViewController(collectionViewLayout: UICollectionViewLayout()))
        
        FriendsViewController.tabBarItem.title = "Friends"
        GroupsViewController.tabBarItem.title = "Groups"
        PhotosViewController.tabBarItem.title = "Photos"
        
        let controllers = [FriendsViewController, GroupsViewController, PhotosViewController]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        navigationController?.pushViewController(tabBarController, animated: true)
        navigationController?.isNavigationBarHidden = true
        //self.view.window?.windowScene?.windows.first?.rootViewController = tabBarController
    }
}
