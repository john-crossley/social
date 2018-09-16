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
}
