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

        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validationService.set(rules: [MinRule(3)], for: "email")

        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validationService.set(rules: [MinRule(3)], for: "password")

        signInButton.is(.disabled)
    }

    @IBAction func didTapSignIn(sender: SocialButton) {
        view.endEditing(true)
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }

        viewModel.signIn(with: email, and: password)
    }
}

extension SignInController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if textField == emailTextField {
            validationService.validate(text, for: "email")
        } else if textField == passwordTextField {
            validationService.validate(text, for: "password")
        }
    }

    private func presentGyoza(with message: String) {
        let gyoza = Gyoza { builder in
            builder.pinTo = .top
            builder.message = message
        }
        gyoza?.show(on: self.view)
    }
}

extension SignInController: SignInViewModelDelegate {
    func didUpdate(state: SignInViewModel.State) {
        switch state {
        case .idle:
            break
        case .loading:
            signInButton.setTitle("Please wait...", for: .normal)
            signInButton.is(.disabled)
        case .loaded:
            coordinator?.feed()
        case .error(let message):
            presentGyoza(with: message)
            signInButton.setTitle("Sign In", for: .normal)
            signInButton.is(.enabled)
        }
    }
}

extension SignInController: FormValidationServiceDelegate {
    func isFormValid(_ isValid: Bool) {
        signInButton.is( isValid ? .enabled : .disabled )
    }
}
