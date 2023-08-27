//
//  ViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 05.08.2023.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeSaver.getData()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        setupViews()
        // AppCode не прилинкуется, потому что в нем ID приложения VK
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=" + AppCode.appCode + "&redirect_uri=https://oauth.vk.com/blank.html&scope=262150&display=mobile&response_type=token")
        webView.load(URLRequest(url: url!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    private func setupViews() {
        view.addSubview(webView)
    }
}

private extension AuthViewController {
    @objc func tap() {
        let FriendsViewController = UINavigationController(rootViewController: FriendsViewController())
        let GroupsViewController = UINavigationController(rootViewController: GroupsViewController())
        let PhotosViewController = UINavigationController(rootViewController: PhotosViewController(collectionViewLayout: UICollectionViewFlowLayout())) // важно collectionViewLayout: UICollectionViewFlowLayout()
        
        FriendsViewController.tabBarItem.title = "Friends"
        GroupsViewController.tabBarItem.title = "Groups"
        PhotosViewController.tabBarItem.title = "Photos"
        
        let controllers = [FriendsViewController, GroupsViewController, PhotosViewController]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        
        navigationController?.pushViewController(tabBarController, animated: true)
        navigationController?.isNavigationBarHidden = true // так есть анимация и нет обратной навигации
        //self.view.window?.windowScene?.windows.first?.rootViewController = tabBarController // так нет антимации
    }
}
extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        NetworkService.token = params["access_token"]!
        NetworkService.userID = params["user_id"]!
        print(NetworkService.token)
        print(NetworkService.userID)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        tap()
    }
}
