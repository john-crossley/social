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

        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        resetRegisterButton()

        validationService.prepare([.name, .email, .password])
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if textField == nameTextField {
            validationService.add(.name, for: text)
        } else if textField == emailTextField {
            validationService.add(.email, for: text)
        } else if textField == passwordTextField {
            validationService.add(.password, for: text)
        }
    }

    @IBAction func didTapRegister(sender: SocialButton) {
        view.endEditing(true)
        guard let user = validationService.userRegister else { return }
        viewModel.register(with: user)
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
            coordinator?.presentFeed()
        case .error(let message):
            resetRegisterButton()
            showMessage(message)
        }
    }

    private func suspendRegisterButton() {
        self.registerButton.setTitle("Please wait...", for: .normal)
        registerButton.layer.opacity = 0.8
        registerButton.isUserInteractionEnabled = false
    }

    private func resetRegisterButton() {
        self.registerButton.setTitle("Create Account", for: .normal)
        self.registerButton.layer.opacity = 1
        registerButton.isUserInteractionEnabled = true
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

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        validationService.validate()
        return true
    }

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
    func didUpdateForm(state: FormValidationService.FormState) {

        switch state {
        case .valid:
            self.registerButton.isEnabled = true
            self.registerButton.layer.opacity = 1
        case .invalid:
            self.registerButton.isEnabled = false
            self.registerButton.layer.opacity = 0.8
        }

    }
}
