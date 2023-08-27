//
//  ImageViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit
final class PhotoViewController: UIViewController {
    private var imageView = UIImageView()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        title = "Image"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            //self.imageView.transform = CGAffineTransform(rotationAngle: .pi/4)
        })
        UIView.animate(withDuration: 3, delay: 1, options: [.autoreverse, .repeat], animations: {
            self.imageView.layer.opacity = 0
        })
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: 50)
        ])
    }
}
