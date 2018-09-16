//
//  Feed.swift
//  Social
//
//  Created by John Crossley on 12/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct Like: Codable {
    let userId: String
}

struct Author: Codable {
    let userId: String
    let name: String
}

struct FeedItem: Codable {
    let post: String
    var likes: [Like] = []
    let author: Author

    var id: String?
    var timestamp: Double?

    init(post: String, author: Author) {
        self.post = post
        self.likes = [Like]()
        self.author = author
        self.id = nil
        self.timestamp = Date().timestamp
    }

    init(post: String, likes: [Like], author: Author) {
        self.init(post: post, author: author)
        self.likes = likes
    }
}
