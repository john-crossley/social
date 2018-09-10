//
//  ViewController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class HomeController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(didTapSignOut(sender:)))
    }

    @objc private func didTapSignOut(sender: UIBarButtonItem) {
        guard viewModel.signOut else { return }
        coordinator?.signIn(.new)
    }
}

