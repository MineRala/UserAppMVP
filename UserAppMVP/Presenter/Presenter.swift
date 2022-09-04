//
//  Presenter.swift
//  UserAppMVP
//
//  Created by Mine Rala on 3.09.2022.
//

import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers<T>(users: T)
    func presentAlert(title: String, messsage: String)
}

class UserPresenter {
    weak var delegate: UserPresenterDelegate?
    private let baseURL = "https://jsonplaceholder.typicode.com/users"

    public func getUsers<T: Decodable>(model: T.Type) {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil else {
                return
            }
            do {
                let users = try JSONDecoder().decode(model, from: data)
                self?.delegate?.presentUsers(users: users)
            } catch {
                print(error)
            }

        }.resume()
    }
    
    public func didTap(user: User) {
        self.delegate?.presentAlert(title: user.name,
                                    messsage: "\(user.name) has an email of \(user.email) & a username of \(user.username)")
    }
}
