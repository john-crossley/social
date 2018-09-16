//
//  UIColor+Extensions.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

extension UIColor {

    struct Theme {
        static let primaryColor: UIColor = UIColor(named: "primaryColor") ?? .white
        static let accentColor: UIColor = UIColor(named: "accentColor") ?? .red
        static let secondaryTextColor: UIColor = UIColor(named: "secondaryTextColor") ?? .lightGray
        static let backgroundColor: UIColor = UIColor(named: "backgroundColor") ?? .white
    }

}
