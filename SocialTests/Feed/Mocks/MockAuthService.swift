//
//  MockAuthService.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
@testable import Social

class MockAuthService: AuthService {
    var isAuthenticated: Bool = true

    func createAccount(user: User.Auth, callback: @escaping CreateAccountCallback) {

    }

    func signOut() -> Bool {
        return true
    }

    func signIn(user: User.Auth, callback: SignInCallback?) {

    }

    var user: User? {
        return User(id: "randomId", name: "Jane McDoughball", email: "jane.doe@example.com", password: "pass")
    }
}
