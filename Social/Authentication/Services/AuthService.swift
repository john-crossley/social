//
//  SignInService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol AuthService {

    typealias CreateAccountCallback = (Result<String>) -> Void
    typealias SignInCallback = (Result<String>) -> Void

    var isAuthenticated: Bool { get }
    func createAccount(user: User.Auth, callback: @escaping CreateAccountCallback)

    @discardableResult
    func signOut() -> Bool

    func signIn(user: User.Auth, callback: SignInCallback?)
    var user: User? { get }
}
