//
//  SocialButton.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

@IBDesignable
class SocialButton: UIButton {

    @IBInspectable
    private var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        renderShadow(intensity: .medium)

        backgroundColor = .accentColor
        setTitleColor(UIColor.white, for: .normal)
    }
}
