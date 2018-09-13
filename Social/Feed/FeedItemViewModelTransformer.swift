//
//  FeedItemViewModelTransformer.swift
//  Social
//
//  Created by John Crossley on 12/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FeedItemViewModelTransformer {
    static func transform(_ items: [FeedItem], for user: User) -> [FeedItemViewModel] {
        return items.map { makeFeedItemViewModel(from: $0, user) }
    }

    private static func makeFeedItemViewModel(from item: FeedItem, _ user: User) -> FeedItemViewModel {
        return FeedItemViewModel(with: item,
                                 isLiked: isLiked(item, userId: user.id))
    }

    private static func isLiked(_ item: FeedItem, userId: String) -> Bool {
        return item.likes.contains(where: { $0.userId == userId })
    }
}
