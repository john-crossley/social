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

    struct Auth {
        let email: String
        let password: String
    }
}
