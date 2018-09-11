//
//  ViewController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension String {
    static let feedCellId: String = "FeedCellId"
}

class FeedController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?

    private let viewModel: FeedViewModel

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(UINib(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: .feedCellId)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    var ref: DocumentReference? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(didTapSignOut(sender:)))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

//        let db = Firestore.firestore()
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

    @objc private func didTapSignOut(sender: UIBarButtonItem) {
        guard viewModel.signOut else { return }

        let controller = UIAlertController(title: "Account Options", message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
            self.coordinator?.signIn(.new)
        }))

        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(controller, animated: true, completion: nil)
    }
}

extension FeedController: UITableViewDelegate {

}

extension FeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .feedCellId, for: indexPath)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

