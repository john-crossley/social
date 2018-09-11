//
//  MinRule.swift
//  Social
//
//  Created by John Crossley on 10/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class MinRule: Rule {

    private let min: Int
    private let message: String

    init(_ min: Int) {
        self.min = min
        self.message = "Not enough characters, minimum is \(min)"
    }

    init(_ min: Int, message: String) {
        self.min = min
        self.message = message
    }

    func validate(_ text: String?) -> ValidationResult {
        guard let text = text else {
            return ValidationResult(isValid: false, message: "You need to enter something here!")
        }

        if text.count < min {
            return ValidationResult(isValid: false, message: message)
        }

        return ValidationResult(isValid: true, message: "")
    }
}
