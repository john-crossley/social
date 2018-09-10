//
//  FormValidationServiceTest.swift
//  SocialTests
//
//  Created by John Crossley on 10/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import XCTest
@testable import Social

class MockFormValidationServiceDelegate: FormValidationServiceDelegate {

    var isValid: Bool = false

    func didUpdateForm(state: FormValidationService.FormState) {
        switch state {
        case .valid: isValid = true
        case .invalid: isValid = false
        }
    }
}

class FormValidationServiceTests: XCTestCase {
    func testItIsInvalidWhenRequirementsAreNotMet() {

        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()

        service.delegate = mockServiceDelegate
        service.prepare([.name, .email, .password])
        service.validate()

        XCTAssertFalse(mockServiceDelegate.isValid)
    }

    func testItIsValidWhenRequirementsMet() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()

        service.delegate = mockServiceDelegate
        service.prepare([.name])
        service.add(.name, for: "John Crossley")
        service.validate()

        XCTAssertTrue(mockServiceDelegate.isValid)
    }

    func testItCanReturnUserRegisterFromValidInput() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()

        service.delegate = mockServiceDelegate
        service.prepare([.name, .email, .password])

        service.add(.name, for: "John Crossley")
        service.add(.email, for: "john@example.com")
        service.add(.password, for: "password")

        let user = service.userRegister!

        XCTAssertEqual(user.email, "john@example.com")
        XCTAssertEqual(user.password, "password")
    }

    func testItCanReturnUserLoginFromValidInput() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()

        service.delegate = mockServiceDelegate
        service.prepare([.name, .email, .password])

        service.add(.name, for: "Jane Doe")
        service.add(.email, for: "jane.doe@example.com")
        service.add(.password, for: "greenbean")

        let user = service.userLogin!

        XCTAssertEqual(user.email, "jane.doe@example.com")
        XCTAssertEqual(user.password, "greenbean")
    }
}
