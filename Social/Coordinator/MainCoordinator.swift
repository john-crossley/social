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

    private let window: UIWindow
    private let authService: AuthService
    let navigationController: UINavigationController

    init(window: UIWindow, authService: AuthService) {
        self.window = window
        self.authService = authService
        self.navigationController = UINavigationController()
        navigationController.pushViewController(makeRootController(), animated: true)
    }

    private func makeRootController() -> UIViewController {
        var controller: CoordinatedViewController

        if authService.isAuthenticated {
            controller = makeHomeController()
        } else {
            controller = AuthController()
        }

        controller.coordinator = self
        return controller
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func auth() {
        present {
            return makeAuthController()
        }
    }

    func presentAuth() {
        reset {
            return [makeAuthController()]
        }
    }

    func presentFeed() {
        reset {
            return [makeHomeController()]
        }
    }

    private func present(block: () -> (UIViewController)) {
        navigationController.pushViewController(block(), animated: true)
    }

    private func reset(block: () -> ([UIViewController])) {
        navigationController.setViewControllers(block(), animated: true)
    }

    private func makeAuthController() -> CoordinatedViewController {
        let viewModel = RegisterViewModel(service: DependencyContainer.authService)
        let controller = RegisterController(with: viewModel, validationService: FormValidationService())
        controller.coordinator = self
        return controller
    }

    private func makeHomeController() -> CoordinatedViewController {
        let homeViewModel = HomeViewModel(authService: authService)
        let controller = HomeController(viewModel: homeViewModel)
        controller.coordinator = self
        return controller
    }
}
