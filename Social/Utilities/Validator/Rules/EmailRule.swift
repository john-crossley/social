//
//  EmailRule.swift
//  Social
//
//  Created by John Crossley on 17/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class EmailRule: Rule {

    var name: String = "email"
    private let message: String

    init(_ message: String = "Please enter a valid email address.") {
        self.message = message
    }

    func validate(_ text: String?) -> ValidationResult {

        guard let text = text else {
            return ValidationResult(isValid: false, message: message)
        }

        let pattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let result = regex.matches(in: text, range: NSRange(location: 0, length: text.count))

            if result.count == 0 {
                return ValidationResult(isValid: false, message: message)
            }
        } catch let error {
            print("Error, something went wrong: \(error.localizedDescription)")
            return ValidationResult(isValid: false, message: message)
        }

        return ValidationResult(isValid: true, message: "")
    }
}
