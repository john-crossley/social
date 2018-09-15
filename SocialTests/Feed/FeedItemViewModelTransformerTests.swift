//
//  FeedItemViewModelTransformerTests.swift
//  SocialTests
//
//  Created by John Crossley on 15/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import XCTest
@testable import Social

class FeedItemViewModelTransformerTests: XCTestCase {

    func testItCanTransformFeedItemIntoViewModel() {

        let loggedInAs = User(id: "123", name: "Mr Henry the Akita", email: "henry.akita@mail.com", password: "password")
        let authorOfPost = Author(userId: "user123", name: "Mai-Yee")

        let item = FeedItem(post: "This is a post!", likes: [], author: authorOfPost)
        let viewModels = FeedItemViewModelTransformer.transform([item], for: loggedInAs)

        let first = viewModels.first!

        XCTAssertEqual(first.author.name, "Mai-Yee")
        XCTAssertEqual(first.author.userId, "user123")

    }

    func testItCanDetectOwnershipOfPost() {
        let loggedInAs = User(id: "abc", name: "Hayao Miyazaki", email: "hayao.miyazaki@ghibli.com", password: "password")
        let authorOfPost = Author(userId: "abc", name: "Hayao Miyazaki")

        let item = FeedItem(post: "Grave of the fireflies is so sad 😔", likes: [], author: authorOfPost)
        let viewModels = FeedItemViewModelTransformer.transform([item], for: loggedInAs)

        let first = viewModels.first!
        XCTAssertTrue(first.doesOwnItem)
    }

    func testItCanDetectIfAPostIsLiked() {
        let loggedInAs = User(id: "312232", name: "John Crossley", email: "john.crossley@example.com", password: "as")
        let authorOfPost = Author(userId: "029303123", name: "Mr Random")

        let item = FeedItem(post: "Should we TDD?",
                            likes: [Like(userId: "312232")],
                            author: authorOfPost)

        let viewModels = FeedItemViewModelTransformer.transform([item], for: loggedInAs)

        let first = viewModels.first!

        XCTAssertTrue(first.isLiked)
        XCTAssertEqual(first.numberOfLikes, 1)
    }

}
