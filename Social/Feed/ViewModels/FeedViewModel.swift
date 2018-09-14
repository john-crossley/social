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
    weak var coordinator: MainCoordinator?

    private let authService: AuthService
    private let feedService: FeedService

    weak var delegate: FeedViewModelDelegate?

    enum State {
        case idle, loading, loaded([FeedItemViewModel]), error
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

    func post(body: String) {
        feedService.saveFeed(item: FeedItem(post: body, likes: []),
                             by: authService.user!, callback: { result in
            self.coordinator?.dismiss()
        })
    }

    func load() {
        self.state = .loading

        guard let user = authService.user else { return }
        
        DispatchQueue(label: "social.background", qos: .userInitiated).async { [unowned self] in
            self.feedService.loadFeedItems(for: user) { result in
                switch result {
                case .success(let models):

                    let viewModels = FeedItemViewModelTransformer.transform(models, for: user)

                    self.state = .loaded(viewModels)

                case .error(let error):
                    print("🔥 Error=\(error.localizedLowercase)")
                }
            }
        }
    }
}
