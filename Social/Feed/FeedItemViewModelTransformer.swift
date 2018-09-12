//
//  FeedItemViewModelTransformer.swift
//  Social
//
//  Created by John Crossley on 12/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FeedItemViewModelTransformer {
    static func transform(_ models: [Feed]) -> [FeedItemViewModel] {
        return models.map { FeedItemViewModel(with: $0) }
    }
}
