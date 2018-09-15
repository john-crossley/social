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
    let isLiked: Bool
    let author: Author
    let doesOwnItem: Bool

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
}
