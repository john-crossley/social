//
//  SignInController.swift
//  Social
//
//  Created by John Crossley on 09/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import GyozaKit

class SignInController: UIViewController, Coordinated {
    var coordinator: MainCoordinator?
    @IBOutlet private var signInButton: SocialButton!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    private let viewModel: SignInViewModel
    private let validationService: FormValidationService

    init(viewModel: SignInViewModel, validationService: FormValidationService) {
        self.viewModel = viewModel
        self.validationService = validationService
        super.init(nibName: "SignInController", bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign In"

        viewModel.delegate = self
        validationService.delegate = self
        validationService.prepare([.email, .password])

        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @IBAction func didTapSignIn(sender: SocialButton) {
        view.endEditing(true)
        guard let user = validationService.userLogin else { return }
        viewModel.signIn(with: user)
    }
}

extension SignInController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if textField == emailTextField {
            validationService.add(.email, for: text)
        } else if textField == passwordTextField {
            validationService.add(.password, for: text)
        }
    }
}

extension SignInController: SignInViewModelDelegate {
    func didUpdate(state: SignInViewModel.State) {
        switch state {
        case .idle:
            break
        case .loading:
            break
        case .loaded:
            coordinator?.presentFeed()
        case .error(let message):
            let gyoza = Gyoza { builder in
                builder.pinTo = .top
                builder.message = message
            }
            gyoza?.show(on: self.view)
        }
    }
}

extension SignInController: FormValidationServiceDelegate {
    func didUpdateForm(state: FormValidationService.FormState) {
        switch state {
        case .valid:
            signInButton.is(.enabled)
        case .invalid(let message):
            signInButton.is(.disabled)
        }
    }
}
