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

    func isFormValid(_ isValid: Bool) {
        self.isValid = isValid
    }
}

class FormValidationServiceTests: XCTestCase {

    func testItIsValidWhenRequirementsMetUsing() {

        let service = FormValidationService()

        service.set(rules: [MinRule(3), MaxRule(12)], for: "username")
        service.validate("jo", for: "username")
        XCTAssertFalse(service.isValid)
        XCTAssertEqual("Not enough characters, minimum is 3", service.errors(for: "username").first!)
    }

    func testItIsValidWhenRequirementsMetUsingDelegate() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()
        service.delegate = mockServiceDelegate

        service.set(rules: [MinRule(3)], for: "username")
        service.set(rules: [MinRule(8)], for: "password")

        service.validate("john.crossley", for: "username")
        service.validate("mySecurePassword", for: "password")

        XCTAssertTrue(mockServiceDelegate.isValid)
    }

    func testItCanValidateMinCharacters() {

        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()
        service.delegate = mockServiceDelegate

        service.set(rules: [MinRule(3), MaxRule(10)], for: "name")
        service.validate("abc123456", for: "name")

        XCTAssertTrue(mockServiceDelegate.isValid)
    }

    func testItCanReturnTheCorrectErrorMessageWhenFailedValidation() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()
        service.delegate = mockServiceDelegate

        service.set(rules: [MaxRule(12)], for: "username")
        service.validate("i_have_a_long_username", for: "username")

        XCTAssertFalse(mockServiceDelegate.isValid)
        XCTAssertEqual("Too many characters, max length is 12", service.errors(for: "username").first!)

        service.set(rules: [MinRule(3)], for: "name")
        service.validate("he", for: "name")

        XCTAssertFalse(mockServiceDelegate.isValid)
        XCTAssertEqual("Not enough characters, minimum is 3", service.errors(for: "name").first!)
    }

    func testItCanValidateEmailAddresses() {
        let service = FormValidationService()
        let mockServiceDelegate = MockFormValidationServiceDelegate()
        service.delegate = mockServiceDelegate

        service.set(rules: [EmailRule()], for: "email")

        service.validate("fake@fake", for: "email")
        XCTAssertFalse(mockServiceDelegate.isValid)

        service.validate("email@email.co", for: "email")
        XCTAssertTrue(mockServiceDelegate.isValid)
    }
}
