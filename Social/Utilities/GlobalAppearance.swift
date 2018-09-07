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
    }

    private func styleNavigationBar() {
        let appearence = UINavigationBar.appearance()
        appearence.barTintColor = .white
        appearence.isTranslucent = true

        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accentColor]
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accentColor]
    }
}
