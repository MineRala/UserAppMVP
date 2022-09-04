//
//  Presenter.swift
//  UserAppMVP
//
//  Created by Mine Rala on 3.09.2022.
//

import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, messsage: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    weak var delegate: PresenterDelegate?
    private let baseURL = "https://jsonplaceholder.typicode.com/users"

    public func setWithDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getUsers() {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decodeObject = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: decodeObject)
            } catch {
                print(error)
            }

        }.resume()
    }
}
