//
//  AuthController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class AuthController: UIViewController {

    @IBOutlet private var titleLabel: UILabel!

    init() {
        super.init(nibName: "AuthController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        titleLabel.textColor = .accentColor
    }
}
