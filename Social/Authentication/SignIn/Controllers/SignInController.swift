//
//  SignInController.swift
//  Social
//
//  Created by John Crossley on 09/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class SignInController: UIViewController, Coordinated {
    var coordinator: MainCoordinator?

    @IBAction func didTapRegister(sender: UIButton) {
        coordinator?.presentAuth()
    }
}
