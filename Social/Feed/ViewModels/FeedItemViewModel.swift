//
//  FeedItemViewModel.swift
//  Social
//
//  Created by John Crossley on 12/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import DateToolsSwift

struct FeedItemViewModel {

    private let feed: FeedItem
    let isLiked: Bool
    let author: Author
    let doesOwnItem: Bool

    var itemId: String? {
        return feed.id
    }

    init(with feed: FeedItem, isLiked: Bool, author: Author, doesOwnItem: Bool) {
        self.feed = feed
        self.isLiked = isLiked
        self.author = author
        self.doesOwnItem = doesOwnItem
    }

    var post: String {
        return feed.post
    }

    var numberOfLikes: Int {
        return self.feed.likes.count
    }

    var timeSince: String {
        guard let timestamp = feed.timestamp else { return "" }
        let date = Date(timeIntervalSince1970: timestamp)

        return date.shortTimeAgoSinceNow
    }
}
