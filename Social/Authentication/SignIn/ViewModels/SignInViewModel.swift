//
//  SignInViewModel.swift
//  Social
//
//  Created by John Crossley on 09/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol SignInViewModelDelegate: class {
    func didUpdate(state: SignInViewModel.State)
}

class SignInViewModel {

    enum State {
        case idle, loading, loaded(String), error(String)
    }

    weak var delegate: SignInViewModelDelegate?
    private var state: State = .idle {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate(state: self.state)
            }
        }
    }

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func signIn(with email: String, and password: String) {
        self.state = .loading
        authService.signIn(user: User.Auth(with: email, and: password)) { result in
            switch result {
            case .success(let message):
                self.state = .loaded(message)
            case .error(let reason):
                self.state = .error(reason)
            }
        }
    }
}
