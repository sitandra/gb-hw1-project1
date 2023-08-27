//
//  TableViewController.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit

class FriendsViewController: UITableViewController
{
    private var networkService = NetworkService()
    private var model: FriendModel? = nil
    private var fileCache = FileCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        model = fileCache.fetchFriends()
        tableView.reloadData();
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileTap))
        tableView.register(FriendViewCell.self, forCellReuseIdentifier: Constants.Indentifiers.friendViewCell)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        loadFriends{}
    }
    
    private func loadFriends(completion: @escaping () -> Void) {
        networkService.getFriends { [weak self] result in
            switch result {
            case .success(let response):
                self?.model = response
                self?.fileCache.addFriends(friends: response.response.items)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.model = self?.fileCache.fetchFriends()
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            completion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.response.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifiers.friendViewCell, for: indexPath)
        guard let cell = cell as? FriendViewCell else {
            return UITableViewCell()
        }
        let model = model?.response.items[indexPath.row]
        cell.setup(friend: model)
        cell.tap = { [weak self] text, photo in
            self?.navigationController?.pushViewController(ProfileViewController(name: text, photo: photo, isUserProfile: false), animated: true)
        }
        
        networkService.getPhoto(imageURL: model?.photoIcon) { [weak cell] imgData in
            guard let image = UIImage(data: imgData) else {return}
            DispatchQueue.main.async {
                cell?.setupImage(image: image)
            }
        }
        return cell
    }

   
}
private extension FriendsViewController {
    @objc func profileTap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .fade
        animation.duration = 1
        self.navigationController?.view.layer.add(animation,  forKey: nil)
        self.navigationController?.pushViewController(ProfileViewController(isUserProfile: true), animated: false)
    }
    @objc func update() {
        loadFriends {[weak self] in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}

private extension FriendsViewController {
    func showAlert() {
        let date = DateHelper.drawDate(date: fileCache.fetchFriendDate())
        let alert = UIAlertController(title: "Can't get data", message: "Last update was \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
