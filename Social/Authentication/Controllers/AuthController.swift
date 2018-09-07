//
//  AuthController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class AuthController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var registerButton: SocialButton!
    @IBOutlet private var loginButton: SocialButton!

    init() {
        super.init(nibName: "AuthController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = .accentColor

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func didTapRegister(sender: SocialButton) {
        navigationController?.pushViewController(RegisterController(), animated: true)
    }
}
