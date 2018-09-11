//
//  FormValidationService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FormInput {
    let rules: [Rule]
    var isValid: Bool = false
    var errors: [String] = []

    init(_ rules: [Rule], isValid: Bool = false) {
        self.rules = rules
        self.isValid = isValid
    }
}

protocol FormValidationServiceDelegate: class {
    func isFormValid(_ isValid: Bool)
}

class FormValidationService {

    weak var delegate: FormValidationServiceDelegate?

    private var inputs: [String: FormInput] = [:]

    func set(rules: [Rule], for label: String) {
        self.inputs[label] = FormInput(rules)
    }

    func errors(for label: String) -> [String] {
        return inputs[label]?.errors ?? []
    }

    var isValid: Bool {
        return inputs.values.filter { !$0.isValid }.isEmpty
    }

    func validate(_ text: String, for label: String) {

        guard let formInput = formInput(for: label) else { return }
        formInput.isValid = true

        for rule in formInput.rules {
            let result = rule.validate(text)

            guard !result.isValid else { continue }

            formInput.isValid = false
            formInput.errors.append(result.message)
        }

        delegate?.isFormValid(self.isValid)
    }

    private func formInput(for label: String) -> FormInput? {
        return inputs[label]
    }

    private func rules(for label: String) -> [Rule] {
        return inputs[label]?.rules ?? []
    }
}
