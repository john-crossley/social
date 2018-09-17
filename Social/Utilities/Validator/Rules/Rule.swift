//
//  Rule.swift
//  Social
//
//  Created by John Crossley on 10/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct ValidationResult {
    let isValid: Bool
    let message: String
}

protocol Rule: class {
    var name: String { get }
    func validate(_ text: String?) -> ValidationResult
}
