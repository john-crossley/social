//
//  UIView+Extensions.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

extension UIView {

    func renderShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.10
        self.layer.masksToBounds = false
    }
}
