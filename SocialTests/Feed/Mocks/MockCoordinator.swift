//
//  MockCoordinator.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
@testable import Social

class MockCoordinator: MainCoordinator {
    var callback: (() -> Void)?
    var didDismiss = false {
        didSet {
            callback?()
        }
    }

    override func dismiss() {
        self.didDismiss = true
    }
}
