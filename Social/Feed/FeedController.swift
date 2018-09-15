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
        didSet { tableView.reloadData() }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        control.tintColor = UIColor(named: "accentColor")
        return control
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(UINib(nibName: "FeedCell", bundle: .main), forCellReuseIdentifier: .feedCellId)
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = UIColor(named: "backgroundColor")
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
        view.backgroundColor = UIColor(named: "backgroundColor")
        title = "Home"

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapSignOut(sender:)))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapEdit(sender:)))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        tableView.refreshControl = refreshControl
        viewModel.delegate = self
//        viewModel.load()
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
            self.coordinator?.signIn(.new)
        }))

        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(controller, animated: true, completion: nil)
    }
}

extension FeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: .feedCellId, for: indexPath) as! FeedCell
        cell.coordinator = coordinator
        cell.bind(to: viewModel)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
}

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
