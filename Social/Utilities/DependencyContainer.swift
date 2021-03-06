//
//  DependencyContainer.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class DependencyContainer {
    static let authService: AuthService = FirebaseAuthService()
    static let feedService: FeedService = FirebaseFeedService()
}
