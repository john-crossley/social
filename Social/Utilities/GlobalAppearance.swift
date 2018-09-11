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
        appearence.tintColor = UIColor.accentColor

        appearence.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.accentColor]
        appearence.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.accentColor]
    }

    private func styleTabBar() {
        let appearence = UITabBar.appearance()
        appearence.isTranslucent = true
        appearence.tintColor = .accentColor
        appearence.barTintColor = .white
    }
}
