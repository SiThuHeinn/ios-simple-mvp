//
//  ViewController.swift
//  MVP-Sample
//
//  Created by Si Thu Hein on 12/02/2022.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate,
                          UITableViewDataSource, UserPresenterDelegate  {
    
    
    private let presenter = UserPresenter()
    
    private var users = [User]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // set up Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.fetchUsers()
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    // ... Presenter functions
    func presenterUsers(users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
        
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    // ... TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(user: users[indexPath.row])
    }

}


