//
//  FollowersTableViewController.swift
//  VK
//
//  Created by Elina on 18/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "customCell"

class FollowersTableViewController: UITableViewController {
    
    var users: [User] = [User(name: "Элина", surname: "Батырова", avatar: UIImage.init(named: "Elina")!, photos: [UIImage.init(named: "heart")!], status: "online (моб.)", profile: [] ), User(name: "Эльвира", surname: "Батырова", avatar: UIImage.init(named: "Elvira")!, photos: [UIImage.init(named: "heart")!], status: "online", profile: [] ), User(name: "Айгуль", surname: "Ризатдинова", avatar: UIImage.init(named: "Information")!, photos: [UIImage.init(named: "heart")!], status: "offline", profile: [])]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        setupRefreshControl()
    
        setupNavigationBar()
        
        cellsRegister()

    }
    
    func cellsRegister() {
        let nib = UINib(nibName: "CustomFollowersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func refreshTableView(sender: UIRefreshControl) {
        
        if users.count > 0 {
        
        users[users.count - 1].avatar = UIImage(named: "ios icon")!
        }
        
        self.tableView.reloadData()
        
        sender.endRefreshing()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomFollowersTableViewCell
        
        let model = users[indexPath.row]
        
        cell.prepareCell(with: model)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            users.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .top)
            
        } else if editingStyle == .insert {
            
            tableView.insertRows(at: [indexPath], with: .middle)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }

}

