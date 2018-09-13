//
//  FirebaseFeedService.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import CodableFirebase

class FirebaseFeedService: FeedService {

    private lazy var db: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        return db
    }()

    private lazy var feedRef = db.collection("users")

    func loadFeedItems(for user: User, callback: @escaping (Result<[FeedItem]>) -> Void) {
        feedRef.order(by: "date", descending: true)
            .limit(to: 1000)
            .getDocuments { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                callback(.error(""))
                return
            }

            do {

                let decoder = FirebaseDecoder()

                let models = try documents.map { document in
                    return try decoder.decode(FeedItem.self, from: document.data())
                }

                callback(.success(models))

            } catch let error {
                callback(.error(error.localizedDescription))
            }
        }
    }

    func saveFeed(item: FeedItem, by user: User, callback: @escaping (Result<String>) -> Void) {
        feedRef.addDocument(data: [
            "date": Date(),
            "post": item.post,
            "likes": item.likes
        ]) { error in
            if let error = error {
                callback(.error(error.localizedDescription))
            } else {
                callback(.success("Document was successfully saved!"))
            }
        }
    }
}
