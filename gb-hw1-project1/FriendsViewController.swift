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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        
        tableView.register(FriendViewCell.self, forCellReuseIdentifier: Constants.Indentifiers.friendViewCell)
        networkService.getFriends { [weak self] friends in
            self?.model = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        
        DispatchQueue.global().async {
            if let url = URL(string: model?.photoIcon ?? ""), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.setupImage(image: UIImage(data: data) ?? UIImage(systemName: "none"))
                }
            }
        }
        /*networkService.getPhoto(imageURL: model?.photoIcon) { [weak cell] imgData in
            guard let image = UIImage(data: imgData) else {return}
            DispatchQueue.main.async {
                cell?.setupImage(image: image)
            }
        }*/
        return cell
    }

    
}
