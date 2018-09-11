//
//  HomeViewModel.swift
//  Social
//
//  Created by John Crossley on 09/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FeedViewModel {
    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    var signOut: Bool {
        return authService.signOut()
    }
}
