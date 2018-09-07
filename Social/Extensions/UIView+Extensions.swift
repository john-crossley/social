//
//  UIView+Extensions.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

extension UIView {
    enum Intensity  {
        case light
        case medium
        case heavy

        var radius: CGFloat {
            switch self {

            case .light: return 1
            case .medium: return 4
            case .heavy: return 8
            }
        }

        var opacity: Float {
            switch self {
            case .light: return 0.15
            case .medium: return 0.25
            case .heavy: return 0.35
            }
        }
    }

    func renderShadow(intensity: Intensity = .medium) {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.accentColor.cgColor
        self.layer.shadowRadius = intensity.radius
        self.layer.shadowOpacity = intensity.opacity
        self.layer.masksToBounds = false
    }
}
