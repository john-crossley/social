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

struct Feed: Codable {
    let post: String
}

class FirebaseFeedService: FeedService {

    private lazy var db: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        return db
    }()

    private lazy var feedRef = db.collection("users")

    func loadFeedItems(for user: User, callback: @escaping (Result<[Feed]>) -> Void) {
        feedRef.getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                callback(.error(""))
                return
            }

            do {

                let decoder = FirebaseDecoder()

                let models = try documents.map { document in
                    return try decoder.decode(Feed.self, from: document.data())
                }

                callback(.success(models))

            } catch let error {
                callback(.error(error.localizedDescription))
            }
        }


//        db.collection("users").getDocuments(completion: { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else { return }
//
//            do {
//                let models = try FirebaseDecoder().decode([Document].self, from: querySnapshot)
//
//                print(models)
//            } catch let erorr {
//                print(">>> i fucking errorrerrred \(error?.localizedDescription)")
//            }
//
//        })
        //        ref = db.collection("users").addDocument(data: [
        //            "post": "Oh hello there, this is my first ever post! 🤭",
        //            "date": Date()
        //        ]) { error in
        //            if let error = error {
        //                print("Error adding document: \(error)")
        //            } else {
        //                print("document was added with ID: \(self.ref!.documentID)")
        //            }
        //        }
    }
}
