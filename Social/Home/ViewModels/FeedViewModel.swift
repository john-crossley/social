//
//  HomeViewModel.swift
//  Social
//
//  Created by John Crossley on 09/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {
    func didUpdate(state: FeedViewModel.State)
}

class FeedViewModel {
    private let authService: AuthService
    private let feedService: FeedService

    weak var delegate: FeedViewModelDelegate?

    enum State {
        case idle, loading, loaded([Feed]), error
    }

    private var state: State = .idle {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate(state: self.state)
            }
        }
    }

    init(authService: AuthService, feedService: FeedService) {
        self.authService = authService
        self.feedService = feedService
    }

    var signOut: Bool {
        return authService.signOut()
    }

    func load() {
        self.state = .loading
        self.feedService.loadFeedItems(for: authService.user!) { result in
            switch result {
            case .success(let models):
                self.state = .loaded(models)
            case .error(let error):
                print("🔥 Error=\(error.localizedLowercase)")
            }
        }
    }
}
