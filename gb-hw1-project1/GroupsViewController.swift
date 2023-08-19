//
//  TableViewController2.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 09.08.2023.
//

import UIKit

class GroupsViewController: UITableViewController
{
    private var networkService = NetworkService()
    private var model: GroupModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        //print(NetworkService().getGroups())
        
        tableView.register(GroupViewCell.self, forCellReuseIdentifier: Constants.Indentifiers.groupViewCell)
        networkService.getGroups() { [weak self] groups in
            self?.model = groups
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifiers.groupViewCell, for: indexPath)
        guard let cell = cell as? GroupViewCell else {
            return UITableViewCell()
        }
        let model = model?.response.items[indexPath.row]
        cell.setup(group: model)
        
        /*DispatchQueue.global().async {
            if let url = URL(string: model?.photoIcon ?? ""), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.setupImage(image: UIImage(data: data) ?? UIImage(systemName: "none"))
                }
            }
        }*/
        networkService.getPhoto(imageURL: model?.photoIcon) { [weak cell] imgData in
            guard let image = UIImage(data: imgData) else {return}
            DispatchQueue.main.async {
                cell?.setupImage(image: image)
            }
        }
        return cell
    }
    
}
