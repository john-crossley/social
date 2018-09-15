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

    enum PresentationStyle {
        case new
        case push
    }

    private let window: UIWindow
    private let authService: AuthService
    private let feedService: FeedService
    let navigationController: UINavigationController

    init(window: UIWindow,
         authService: AuthService,
         feedService: FeedService,
         navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.authService = authService
        self.feedService = feedService
        self.navigationController = navigationController
        navigationController.pushViewController(makeRootController(), animated: true)
    }

    private func makeRootController() -> UIViewController {
        var controller: CoordinatedViewController

        if authService.isAuthenticated {
            controller = makeFeedController()
        } else {
            controller = makeAuthController()
        }

        controller.coordinator = self
        return controller
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func auth(_ style: PresentationStyle) {
        let controller = makeAuthController()

        if style == .new {
            new { [controller] }
        } else if style == .push {
            push { controller }
        }
    }

    func signIn(_ style: PresentationStyle) {
        let viewModel = SignInViewModel(authService: DependencyContainer.authService)
        let controller = SignInController(viewModel: viewModel, validationService: FormValidationService())
        controller.coordinator = self

        if style == .push {
            push { controller }
        } else if style == .new {
            new { [controller] }
        }
    }

    func register() {
        push {
            let viewModel = RegisterViewModel(service: DependencyContainer.authService)
            let controller = RegisterController(with: viewModel, validationService: FormValidationService())
            controller.coordinator = self
            return controller
        }
    }

    func feed() {
        new { return [makeFeedController()] }
    }

    func newFeedItem() {
        modal {
            let viewModel = FeedViewModel(authService: authService, feedService: feedService)
            viewModel.coordinator = self
            return CreateFeedController(viewModel: viewModel)
        }
    }

    func moreOptions() {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Delete Item", style: .destructive, handler: nil))
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        navigationController.present(controller, animated: true, completion: nil)
    }

    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    private func makeAuthController() -> CoordinatedViewController {
        let controller = AuthController()
        controller.coordinator = self
        return controller
    }

    private func push(block: () -> (UIViewController)) {
        navigationController.pushViewController(block(), animated: true)
    }

    private func new(shouldAnimate: Bool = true, block: () -> ([UIViewController])) {
        navigationController.setViewControllers(block(), animated: shouldAnimate)
    }

    private func modal(block: () -> (UIViewController)) {
        navigationController.present(block(), animated: true, completion: nil)
    }

    private func makeFeedController() -> CoordinatedViewController {
        let viewModel = FeedViewModel(authService: authService, feedService: feedService)
        let controller = FeedController(viewModel: viewModel)
        controller.coordinator = self
        return controller
    }
}
