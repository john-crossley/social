//
//  MainCoordinatorTests.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import XCTest
@testable import Social

class MockNavigationController: UINavigationController {
    var current: UIViewController!

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        current = viewController
        super.pushViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        current = viewControllers.first!
        super.setViewControllers(viewControllers, animated: animated)
    }
}

class MainCoordinatorTests: XCTestCase {

    func testItReturnsFeedControllerIfAuthenticated() {
        let auth = MockAuthService()
        let feed = MockFeedService()
        auth.isAuthenticated = true

        let coordinator = MainCoordinator(window: UIWindow(),
                                          authService: auth,
                                          feedService: feed)

        coordinator.start()

        let controller = coordinator.navigationController.viewControllers.first!
        XCTAssertTrue(controller is FeedController)
    }

    func testItReturnsAuthControllerIfNotAuthenticated() {
        let auth = MockAuthService()
        let feed = MockFeedService()
        auth.isAuthenticated = false

        let coordinator = MainCoordinator(window: UIWindow(),
                                          authService: auth,
                                          feedService: feed)

        coordinator.start()

        let controller = coordinator.navigationController.viewControllers.first!
        XCTAssertTrue(controller is AuthController)
    }

    func testItCanPushOnStack() {

        let auth = MockAuthService()
        let feed = MockFeedService()
        let mockNav = MockNavigationController()

        let coordinator = MainCoordinator(window: UIWindow(),
                                          authService: auth,
                                          feedService: feed,
                                          navigationController: mockNav)

        coordinator.signIn(.new)

        XCTAssertTrue(mockNav.current is SignInController)

        coordinator.feed()

        XCTAssertTrue(mockNav.current is FeedController)

        coordinator.register()

        XCTAssertTrue(mockNav.current is RegisterController)
    }

}
