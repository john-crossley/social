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
    var user: User? {
        guard let user = Auth.auth().currentUser,
            let email = user.email else { return nil }
        return User(id: user.uid, name: user.displayName, email: email, password: nil)
    }

    var isAuthenticated: Bool {
        return self.user != nil
    }

    func createAccount(user: User.Auth, callback: @escaping (Result<String>) -> Void) {

        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in

            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = user.name
            changeRequest?.commitChanges(completion: nil)

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

    func signIn(user: User.Auth, callback: SignInCallback?) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
            if let error = error {
                callback?(.error(error.localizedDescription))
                return
            }

            callback?(.success("Success!"))
        }
    }
}
