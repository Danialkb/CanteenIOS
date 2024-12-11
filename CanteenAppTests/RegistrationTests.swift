//
//  RegistrationTests.swift
//  CanteenApp
//
//  Created by мак on 11.12.2024.
//

import XCTest
import Alamofire
@testable import CanteenApp

class RegistrationViewControllerTests: XCTestCase {

    var viewController: RegistrationViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testInputsAreValidWithValidInputs() {
        viewController.nameInput.text = "John"
        viewController.surnameInput.text = "Doe"
        viewController.emailInput.text = "john.doe@example.com"
        viewController.passwordInput.text = "password123"

        let result = viewController.inputsAreValid()

        XCTAssertTrue(result, "inputsAreValid should return true when all fields are filled")
    }

    func testInputsAreValidWithEmptyFields() {
        viewController.nameInput.text = ""
        viewController.surnameInput.text = "Doe"
        viewController.emailInput.text = "john.doe@example.com"
        viewController.passwordInput.text = "password123"

        let result = viewController.inputsAreValid()

        XCTAssertFalse(result, "inputsAreValid should return false when any field is empty")
    }

    func testRegisterWithValidInputsCallsUserService() {
        viewController.nameInput.text = "John"
        viewController.surnameInput.text = "Doe"
        viewController.emailInput.text = "john.doe@example.com"
        viewController.passwordInput.text = "password123"

        let mockUserService = MockUserService()
        viewController.userService = mockUserService

        viewController.register(UIButton())

        XCTAssertTrue(mockUserService.didCallSendRegisterRequest, "sendRegisterRequest should be called when inputs are valid")
    }
}

class MockUserService: UserService {
    var didCallSendRegisterRequest = false

    override func sendRegisterRequest(registrationData: RegistrationSchema, completion: @escaping (Result<RegistrationResponse, AFError>) -> Void) {
        didCallSendRegisterRequest = true
        completion(.success(RegistrationResponse(session_id: "session")))
    }
}

