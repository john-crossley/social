//
//  AppDelegate.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appearance = GlobalAppearance()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupFirebase()
        setupApp()

        return true
    }

}

fileprivate typealias CustomAppDelegate = AppDelegate
extension CustomAppDelegate {

    private func setupFirebase() {
//        FirebaseApp.configure()
    }

    private func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeController())
    }

}

