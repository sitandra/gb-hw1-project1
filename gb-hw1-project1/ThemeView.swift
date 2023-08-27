//
//  ThemeView.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

import UIKit

protocol ThemeViewDelegate: AnyObject {
    func updateColor()
}

final class ThemeView: UIView {
    weak var delegate: ThemeViewDelegate?
    
    private var themeTitle: UILabel = {
        let label = UILabel()
        label.text = "Choose theme:"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var theme1Button: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        //button.setTitle("Select Theme", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        //button.setTitleColor(.green, for: .highlighted)
        button.backgroundColor = WhiteTheme().backgroundColor
        return button
    }()
    
    private var theme2Button: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = BlueTheme().backgroundColor
        return button
    }()
    
    private var theme3Button: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = GreenTheme().backgroundColor
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.currentTheme.backgroundColor
        theme1Button.addTarget(self, action: #selector(tap1Theme), for: .touchUpInside)
        theme2Button.addTarget(self, action: #selector(tap2Theme), for: .touchUpInside)
        theme3Button.addTarget(self, action: #selector(tap3Theme), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(themeTitle)
        addSubview(theme1Button)
        addSubview(theme2Button)
        addSubview(theme3Button)
        setupConstraints()
    }
    
    private func setupConstraints(){
        themeTitle.translatesAutoresizingMaskIntoConstraints = false
        theme1Button.translatesAutoresizingMaskIntoConstraints = false
        theme2Button.translatesAutoresizingMaskIntoConstraints = false
        theme3Button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            themeTitle.topAnchor.constraint(equalTo: self.topAnchor),
            themeTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            themeTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            themeTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            theme2Button.topAnchor.constraint(equalTo: themeTitle.bottomAnchor, constant: 70),
            theme1Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            theme1Button.leadingAnchor.constraint(equalTo: leadingAnchor),
            theme1Button.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            theme2Button.topAnchor.constraint(equalTo: theme1Button.bottomAnchor, constant: 20),
            theme2Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            theme2Button.leadingAnchor.constraint(equalTo: leadingAnchor),
            theme2Button.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            theme3Button.topAnchor.constraint(equalTo: theme2Button.bottomAnchor, constant: 20),
            theme3Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            theme3Button.leadingAnchor.constraint(equalTo: leadingAnchor),
            theme3Button.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
}
private extension ThemeView {
    @objc func tap1Theme() {
        Theme.currentTheme  = WhiteTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
    @objc func tap2Theme() {
        Theme.currentTheme  = BlueTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
    @objc func tap3Theme() {
        Theme.currentTheme  = GreenTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
        ThemeSaver.putData()
    }
}
