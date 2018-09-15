//
//  RegisterViewModel.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol RegisterViewModelDelegate: class {
    func didUpdate(state: RegisterViewModel.State)
}

class RegisterViewModel {

    enum State {
        case idle
        case loading
        case loaded(String)
        case error(String)
    }

    private let authService: AuthService

    weak var delegate: RegisterViewModelDelegate?

    private var state: State = .idle {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate(state: self.state)
            }
        }
    }

    init(service: AuthService) {
        self.authService = service
    }

    func register(with name: String, email: String, and password: String) {
        self.state = .loading

        self.authService.createAccount(user: User.Auth(name: name, email: email, password: password)) { result in
            switch result {
            case .success(let message):
                self.state = .loaded(message)
            case .error(let message):
                self.state = .error(message)
            }
        }
    }
}
