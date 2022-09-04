//
//  ViewController.swift
//  UserAppMVP
//
//  Created by Mine Rala on 3.09.2022.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private let presenter = UserPresenter()
    public var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Navigation Bar
        self.navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Table
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Presenter
        presenter.setWithDelegate(delegate: self)
        presenter.getUsers()
        tableView.frame = view.bounds
    }
}

// MARK: - TableView Delagae & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = users[indexPath.row].name
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Ask presenter to handle the tap
    }
}

// MARK: - UserPresenterDelegate
extension ViewController: UserPresenterDelegate {
    func presentUsers(users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, messsage: String) {
        
    }
    
    
}

