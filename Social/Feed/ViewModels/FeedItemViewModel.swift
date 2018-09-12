//
//  FeedItemViewModel.swift
//  Social
//
//  Created by John Crossley on 12/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct FeedItemViewModel {

    private let feed: FeedItem

    init(with feed: FeedItem) {
        self.feed = feed
    }

    var post: String {
        return feed.post
    }
}
