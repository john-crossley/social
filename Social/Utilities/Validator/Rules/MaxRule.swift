//
//  MaxRule.swift
//  Social
//
//  Created by John Crossley on 10/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class MaxRule: Rule {
    var name: String = "max"

    private let max: Int
    private let message: String

    init(_ max: Int) {
        self.max = max
        self.message = "Too many characters, max length is \(max)"
    }

    init(_ max: Int, message: String) {
        self.max = max
        self.message = message
    }

    func validate(_ text: String?) -> ValidationResult {
        guard let text = text else {
            return ValidationResult(isValid: false, message: "You need to enter something here.")
        }

        if text.count > max {
            return ValidationResult(isValid: false, message: message)
        }

        return ValidationResult(isValid: true, message: "")
    }
}
