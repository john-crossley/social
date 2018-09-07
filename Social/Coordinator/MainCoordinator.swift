//
//  MainCoordinator.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    typealias CoordinatedViewController = UIViewController & Coordinated

    let navigationController: UINavigationController

    enum Root {
        case authentication, home
    }

    init(root: Root) {
        var controller = MainCoordinator.rootController(for: root)
        navigationController = controller.embedNavController()
        controller.coordinator = self
    }

    private static func rootController(for root: Root) -> CoordinatedViewController {
        switch root {
        case .authentication: return AuthController()
        case .home: return HomeController()
        }
    }

    private func present(block: () -> (UIViewController)) {
        navigationController.pushViewController(block(), animated: true)
    }
}
