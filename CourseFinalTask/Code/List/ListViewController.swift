//
//  ListViewController.swift
//  CourseFinalTask
//
//  Created by Nikita on 21.12.2021.
//

import UIKit
import DataProvider

class ListViewController: UIViewController {
    
    var users: [User] = []
    
    var mainView: ListView {
        return view as! ListView
    }
    
    override func loadView() {
        let view = ListView()
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        
        cell.imageView!.image = user.avatar ?? UIImage(named: "profile")
        cell.textLabel!.text = user.username
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = ProfileViewController()
        profileVC.userID = users[indexPath.row].id
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
