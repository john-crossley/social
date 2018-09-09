//
//  FirebaseAuthService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService: AuthService {

    var isAuthenticated: Bool {
        return Auth.auth().currentUser != nil
    }

    func createAccount(user: UserRegister, callback: @escaping (Result<String>) -> Void) {

        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in

            if let error = error {
                callback(.error(error.localizedDescription))
                return
            }

            callback(.success("Thanks for registering to an account on Sōsharu. Please check your email and verify your account."))

        }

    }

    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch let error {
            print("Unable to sign out. Reason=\(error.localizedDescription)")
        }

        return false
    }

}
