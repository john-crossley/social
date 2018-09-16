//
//  GlobalAppearance.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class GlobalAppearance {

    init() {
        styleNavigationBar()
        styleTabBar()
    }

    private func styleNavigationBar() {
        let appearence = UINavigationBar.appearance()
        appearence.barTintColor = .white
        appearence.isTranslucent = true
        appearence.tintColor = UIColor.Theme.accentColor

        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.accentColor]
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Theme.accentColor]
    }

    private func styleTabBar() {
        let appearence = UITabBar.appearance()
        appearence.isTranslucent = true
        appearence.tintColor = UIColor.Theme.accentColor
        appearence.barTintColor = .white
    }
}
