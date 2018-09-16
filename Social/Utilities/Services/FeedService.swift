//
//  FeedService.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol FeedService {
    func loadFeedItems(for user: User, callback: @escaping (Result<[FeedItem]>) -> Void)
    func saveFeed(item: FeedItem, by user: User, callback: @escaping (Result<String>) -> Void)
    func removeItem(by id: String, callback: @escaping (Result<String>) -> Void)
}
