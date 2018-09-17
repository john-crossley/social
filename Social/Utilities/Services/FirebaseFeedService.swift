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

        feedRef.order(by: "timestamp", descending: true)
            .limit(to: 1000)
            .addSnapshotListener { (querySnapshot, error) in

                guard let documents = querySnapshot?.documents else {
                    callback(.error("Unable to retrieve documents from snapshot."))
                    return
                }

                do {
                    let decoder = FirebaseDecoder()
                    let models: [FeedItem] = try documents.map { document in
                        var item = try decoder.decode(FeedItem.self, from: document.data())
                        item.id = document.reference.documentID
                        return item
                    }

                    callback(.success(models))

                } catch let error {
                    callback(.error(error.localizedDescription))
                }

        }
    }

    func saveFeed(item: FeedItem, by user: User, callback: @escaping (Result<String>) -> Void) {
        feedRef.addDocument(data: [
            "timestamp": item.timestamp ?? Date().timestamp,
            "post": item.post,
            "likes": item.likes,
            "author": [
                "userId": item.author.userId,
                "name": item.author.name
            ]
        ]) { error in
            if let error = error {
                callback(.error(error.localizedDescription))
            } else {
                callback(.success("Document was successfully saved!"))
            }
        }
    }

    func removeItem(by id: String, callback: @escaping (Result<String>) -> Void) {
        feedRef.document(id).delete { (error) in
            if let error = error {
                callback(.error(error.localizedDescription))
                return
            }

            callback(.success("done"))
        }
    }
}
