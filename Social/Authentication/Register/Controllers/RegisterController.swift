//
//  RegisterController.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import GyozaKit

class RegisterController: UIViewController, Coordinated {
    weak var coordinator: MainCoordinator?

    private let viewModel: RegisterViewModel
    private let validationService: FormValidationService

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var registerButton: SocialButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    init(with viewModel: RegisterViewModel, validationService: FormValidationService) {
        self.viewModel = viewModel
        self.validationService = validationService
        super.init(nibName: "RegisterController", bundle: .main)

        self.validationService.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        view.backgroundColor = .white
        title = "Create Account"
        parepareForm()
    }

    private func parepareForm() {
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validationService.set(rules: [MinRule(3)], for: "name")

        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validationService.set(rules: [MinRule(3)], for: "email")

        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validationService.set(rules: [MinRule(3)], for: "password")

        resetRegisterButton()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if textField == nameTextField {
            validationService.validate(text, for: "name")
        } else if textField == emailTextField {
            validationService.validate(text, for: "email")
        } else if textField == passwordTextField {
            validationService.validate(text, for: "password")
        }
    }

    @IBAction func didTapRegister(sender: SocialButton) {
        view.endEditing(true)
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        viewModel.register(with: name, email: email, and: password)
    }
}

extension RegisterController: RegisterViewModelDelegate {
    func didUpdate(state: RegisterViewModel.State) {
        switch state {
        case .idle: break
        case .loading:
            suspendRegisterButton()
        case .loaded:
            resetRegisterButton()
            coordinator?.feed()
        case .error(let message):
            resetRegisterButton()
            showMessage(message)
        }
    }

    private func suspendRegisterButton() {
        self.registerButton.setTitle("Please wait...", for: .normal)
        registerButton.is(.disabled)
    }

    private func resetRegisterButton() {
        self.registerButton.setTitle("Create Account", for: .normal)
        registerButton.is(.disabled)
    }

    private func showMessage(_ message: String) {
        let gyoza = Gyoza { builder in
            builder.pinTo = .top
            builder.message = message
        }

        gyoza?.show(on: self.view)
    }
}

extension RegisterController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }

        return true
    }
}

extension RegisterController: FormValidationServiceDelegate {
    func isFormValid(_ isValid: Bool) {
        registerButton.is( isValid ? .enabled : .disabled )
    }
}
