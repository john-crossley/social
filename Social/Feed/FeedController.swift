//
//  ViewController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import SnapKit
import GyozaKit

fileprivate extension String {
    static let feedCellId: String = "FeedCellId"
}

class FeedController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?

    private let viewModel: FeedViewModel
    private var viewModels: [FeedItemViewModel] = [] {
        didSet { collectionView.reloadData() }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        control.tintColor = UIColor.Theme.accentColor
        return control
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.Feed.spacing
        layout.minimumLineSpacing = Constants.Feed.spacing
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.Theme.backgroundColor
        view.delegate = self
        view.dataSource = self
        view.register(UINib(nibName: "FeedCell", bundle: .main), forCellWithReuseIdentifier: .feedCellId)
        return view
    }()

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme.backgroundColor
        title = "My Stream"

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapSignOut(sender:)))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapEdit(sender:)))

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        collectionView.refreshControl = refreshControl
        viewModel.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }

    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        viewModel.load()
    }

    @objc private func didTapEdit(sender: UIBarButtonItem) {
        coordinator?.newFeedItem()
    }

    @objc private func didTapSignOut(sender: UIBarButtonItem) {
        guard viewModel.signOut else { return }

        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
            self.coordinator?.auth(.new)
        }))

        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(controller, animated: true, completion: nil)
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .feedCellId, for: indexPath) as! FeedCell

        cell.bind(to: viewModels[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width - (Constants.Feed.spacing * 2), height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.Feed.spacing,
                            left: 0,
                            bottom: Constants.Feed.spacing,
                            right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! FeedCell
//        
    }
}

//extension FeedController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//extension FeedController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let viewModel = viewModels[indexPath.row]
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: .feedCellId, for: indexPath) as! FeedCell
//        cell.bind(to: viewModel)
//        cell.delegate = self
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModels.count
//    }
//}

extension FeedController: FeedViewModelDelegate {
    func didUpdate(state: FeedViewModel.State) {
        switch state {

        case .idle: break
        case .loading: break
        case .loaded(let viewModels):
            refreshControl.endRefreshing()
            self.viewModels = viewModels
        case .error:
            let gyoza = Gyoza { builder in
                builder.pinTo = .top
                builder.message = "Something went wrong!"
            }

            gyoza?.show(on: self.view)
        }
    }
}

extension FeedController: FeedCellDelegate {
    func didTapOptions(for itemId: String) {
        coordinator?.moreOptions(for: itemId) { choice in
            switch choice {
            case .delete:
                self.viewModel.removeItem(by: itemId)
                break
            case .cancel:
                break
            }
        }
    }
}
