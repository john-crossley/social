//
//  User.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct User {
    let id: String
    var name: String?
    let email: String
    var password: String?

    var author: Author {
        return Author(userId: self.id, name: self.name ?? self.email)
    }

    struct Auth {
        var name: String?
        let email: String
        let password: String

        init(name: String, email: String, password: String) {
            self.name = name
            self.email = email
            self.password = password
        }

        init(with email: String, and password: String) {
            self.name = nil
            self.email = email
            self.password = password
        }
    }
}
