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
    }
    
    private var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(systemName: "person"))
        //logo.sizeToFit()
        return logo
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .red
        label.text = "Авторизация"
        return label
    }()
    
    private var inputLogin: UITextField = {
        let input = UITextField()
        input.textAlignment = .left
        input.borderStyle = .line
        input.tintColor = .green
        input.text = "Логин"
        return input
    }()
    
    private var inputPass: UITextField = {
        let input = UITextField()
        input.textAlignment = .left
        input.borderStyle = .line
        input.tintColor = .green
        input.text = "Пароль"
        return input
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Войти", for: .normal)
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
            logo.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            logo.heightAnchor.constraint(equalToConstant: view.frame.size.width/2),
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputLogin.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            inputLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/5),
            inputLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/5),
            
            inputPass.topAnchor.constraint(equalTo: inputLogin.bottomAnchor, constant: 20),
            inputPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputPass.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/5),
            inputPass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/5),
            
            button.topAnchor.constraint(equalTo: inputPass.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width/10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width/10),
        ])
    }
}

