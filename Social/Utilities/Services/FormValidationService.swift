//
//  FormValidationService.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FormInput {

    enum Status {
        case unchecked, valid, invalid
    }

    var status: Status = .unchecked

    let rules: [Rule]
    var errors: [String: String] = [:]

    var hasErrors: Bool {
        return !errors.isEmpty || status == .unchecked
    }

    init(_ rules: [Rule]) {
        self.rules = rules
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
        return rules(for: label).compactMap { self.inputs[label]?.errors[$0.name] }
    }

    var isValid: Bool {
        return inputs.values.filter { $0.hasErrors }.isEmpty
    }

    func validate(_ text: String, for label: String) {

        guard let formInput = formInput(for: label) else { return }

        for rule in formInput.rules {
            let result = rule.validate(text)

            if result.isValid {
                formInput.errors[rule.name] = nil
                formInput.status = .valid
            } else {
                formInput.errors[rule.name] = result.message
                formInput.status = .invalid
            }
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
