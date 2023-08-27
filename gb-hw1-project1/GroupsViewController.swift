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
    private var fileCache = FileCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        model = fileCache.fetchGroups()
        tableView.reloadData();
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        
        tableView.register(GroupViewCell.self, forCellReuseIdentifier: Constants.Indentifiers.groupViewCell)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        loadGroups{}
    }
    
    private func loadGroups(completion: @escaping () -> Void) {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let response):
                self?.model = response
                self?.fileCache.addGroups(groups: response.response.items)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.model = self?.fileCache.fetchGroups()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifiers.groupViewCell, for: indexPath)
        guard let cell = cell as? GroupViewCell else {
            return UITableViewCell()
        }
        let model = model?.response.items[indexPath.row]
        cell.setup(group: model)
        
        networkService.getPhoto(imageURL: model?.photoIcon) { [weak cell] imgData in
            guard let image = UIImage(data: imgData) else {return}
            DispatchQueue.main.async {
                cell?.setupImage(image: image)
            }
        }
        return cell
    }
    
}
private extension GroupsViewController {
    @objc func update() {
        loadGroups {[weak self] in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}
private extension GroupsViewController {
    func showAlert() {
        let date = DateHelper.drawDate(date: fileCache.fetchGroupDate())
        let alert = UIAlertController(title: "Can't get data", message: "Last update was \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
