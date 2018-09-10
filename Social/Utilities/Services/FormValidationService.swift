//
//  FormValidationService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum FormValidationError: Error {
    case empty
    case invalidInput
}

protocol FormValidationServiceDelegate: class {
    func didUpdateForm(state: FormValidationService.FormState)
}

class FormValidationService {

    enum FormState {
        case valid, invalid(FormValidationError)
    }

    private var formState: FormState = .invalid(.empty)

    weak var delegate: FormValidationServiceDelegate?

    enum FormInput: CaseIterable {
        case name
        case email
        case password
    }

    private var inputs: [FormInput: String] = [:]

    func prepare(_ fields: [FormInput]) {
        fields.forEach { inputs[$0] = "" }
        self.formState = .invalid(.empty)
        delegate?.didUpdateForm(state: self.formState)
    }

    func add(_ input: FormInput, for value: String) {
        self.inputs[input] = value.trimmingCharacters(in: .whitespaces)
        validate()
    }

    func validate() {
        for (key, value) in inputs {
            print("key=\(key)", "value=\(value)")
            if value.count > 3 {
                self.formState = .valid
            } else {
                self.formState = .invalid(.invalidInput)
            }
        }

        delegate?.didUpdateForm(state: self.formState)
    }

    var userRegister: UserRegister? {
        guard let email = inputs[.email],
            let password = inputs[.password] else { return nil }
        return UserRegister(email: email, password: password)
    }

    var userLogin: UserLogin? {
        guard let email = inputs[.email],
            let password = inputs[.password] else { return nil }
        return UserLogin(email: email, password: password)
    }
}
