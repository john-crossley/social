//
//  MockFeedService.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
@testable import Social

class MockFeedService: FeedService {

    private var items: [FeedItem] = [
        FeedItem(post: "How many light years away is Mars?", likes: [], author: Author(userId: "123abc", name: "John Smith")),
        FeedItem(post: "Have you seen My Neighbor Totoro?", likes: [], author: Author(userId: "dasda", name: "James Dean")),
        FeedItem(post: "Hello, World! 🌍", likes: [], author: Author(userId: "mbmnb", name: "Jane Doe")),
    ]

    func loadFeedItems(for user: User, callback: @escaping (Result<[FeedItem]>) -> Void) {
        callback(.success(items))
    }

    func saveFeed(item: FeedItem, by user: User, callback: @escaping (Result<String>) -> Void) {
        callback(.success(""))
    }
}

class MockErrorFeedService: FeedService {

    private var items: [FeedItem] = []

    func loadFeedItems(for user: User, callback: @escaping (Result<[FeedItem]>) -> Void) {
        callback(.error("Unable to fetch items"))
    }

    func saveFeed(item: FeedItem, by user: User, callback: @escaping (Result<String>) -> Void) {}
}
