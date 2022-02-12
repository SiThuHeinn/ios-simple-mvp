//
//  UserPresenter.swift
//  MVP-Sample
//
//  Created by Si Thu Hein on 12/02/2022.
//

import Foundation
import UIKit




protocol UserPresenterDelegate: AnyObject {
    func presenterUsers(users: [User])
    func presentAlert(title: String, message: String)
}


typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    
    public func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
 
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            guard let data = data, error == nil else { return }
        
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presenterUsers(users: users)
            } catch {
                print(error)
            }
        }
        
        
        task.resume()
    }
    
    public func didTap(user: User) {
        let title = user.name
        let message = "\(user.name) has an email \(user.email) & username is \(user.name)"
        delegate?.presentAlert(title: title, message: message)
    }

}
