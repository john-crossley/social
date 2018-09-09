//
//  SignInService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

protocol AuthService {

    typealias CreateAccountCallback = (Result<String>) -> Void

    func createAccount(user: UserRegister, callback: @escaping CreateAccountCallback)
    var isAuthenticated: Bool { get }
}