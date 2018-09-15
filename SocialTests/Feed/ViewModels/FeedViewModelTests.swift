//
//  FeedViewModel.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import XCTest
@testable import Social

class MockFeedViewModelDelegate: FeedViewModelDelegate {

    var callback: (() -> Void)?

    var errorMessage: String? {
        didSet { callback?() }
    }

    var items: [FeedItemViewModel] = [] {
        didSet {
            callback?()
        }
    }

    func didUpdate(state: FeedViewModel.State) {

        if case .loaded(let loaded) = state {
            self.items = loaded
            return
        }

        if case .error(let error) = state {
            self.errorMessage = error
            return
        }
    }
}

class FeedViewModelTests: XCTestCase {

    var didReturnItemsExp: XCTestExpectation?

    override func setUp() {
        super.setUp()
        didReturnItemsExp = self.expectation(description: "didReturnItemsExp")
    }

    func testItCanReturnCorrectNumberOfItems() {
        let viewModel = makeFeedViewModel(serviceState: .success)
        let mockDelegate = MockFeedViewModelDelegate()

        viewModel.delegate = mockDelegate

        mockDelegate.callback = {
            self.didReturnItemsExp?.fulfill()
            self.didReturnItemsExp = nil
        }

        viewModel.load()

        wait(for: [didReturnItemsExp!], timeout: 5)

        XCTAssertEqual(mockDelegate.items.count, 3)
    }

    func testItParsesFeedItemsIntoViewModels() {
        let viewModel = makeFeedViewModel(serviceState: .success)
        let mockDelegate = MockFeedViewModelDelegate()

        viewModel.delegate = mockDelegate

        mockDelegate.callback = {
            self.didReturnItemsExp?.fulfill()
            self.didReturnItemsExp = nil
        }

        viewModel.load()

        wait(for: [didReturnItemsExp!], timeout: 5)

        XCTAssertEqual(mockDelegate.items.first!.post, "How many light years away is Mars?")
    }

    func testItCanCatchErrorMessageState() {
        let viewModel = makeFeedViewModel(serviceState: .error)
        let mockDelegate = MockFeedViewModelDelegate()

        viewModel.delegate = mockDelegate
        mockDelegate.callback = {
            self.didReturnItemsExp?.fulfill()
        }

        viewModel.load()

        wait(for: [didReturnItemsExp!], timeout: 5)

        XCTAssertEqual(mockDelegate.errorMessage!, "Unable to fetch items")
    }

    func testSuccessfullyPostingAnItemCallsTheCoordinatorToDismiss() {
        let viewModel = makeFeedViewModel(serviceState: .success)
        let mockDelegate = MockFeedViewModelDelegate()

        let mockCoordinator = MockCoordinator(window: UIWindow(),
                                              authService: MockAuthService(),
                                              feedService: MockFeedService())

        viewModel.coordinator = mockCoordinator
        viewModel.delegate = mockDelegate

        mockCoordinator.callback = {
            self.didReturnItemsExp?.fulfill()
        }

        viewModel.post(body: "Hello, World!")

        wait(for: [didReturnItemsExp!], timeout: 5)

        XCTAssertTrue(mockCoordinator.didDismiss)
    }

    override func tearDown() {
        didReturnItemsExp = nil
        super.tearDown()
    }

    private enum FeedServiceState {
        case error
        case success
    }

    private func makeFeedViewModel(serviceState: FeedServiceState) -> FeedViewModel {

        var mockFeedService: FeedService!
        switch serviceState {
        case .error:
            mockFeedService = MockErrorFeedService()
        case .success:
            mockFeedService = MockFeedService()
        }

        return FeedViewModel(authService: MockAuthService(), feedService: mockFeedService)
    }
}
