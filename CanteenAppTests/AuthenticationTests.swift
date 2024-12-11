//
//  AuthenticationTests.swift
//  CanteenApp
//
//  Created by мак on 11.12.2024.
//


import XCTest
import Alamofire
@testable import CanteenApp

class AuthenticationViewControllerTests: XCTestCase {

    var viewController: AuthenticationViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationViewController") as? AuthenticationViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testInputsAreValidWithValidInputs() {
        viewController.emailInput.text = "test@example.com"
        viewController.passwordInput.text = "password123"

        let result = viewController.inputsAreValid()

        XCTAssertTrue(result, "inputsAreValid should return true when both fields are filled")
    }

    func testInputsAreValidWithEmptyFields() {
        viewController.emailInput.text = ""
        viewController.passwordInput.text = "password123"

        let result = viewController.inputsAreValid()

        XCTAssertFalse(result, "inputsAreValid should return false when any field is empty")
    }
    
    func testLogin_withValidInputsCallsUserService() {
        viewController.emailInput.text = "test@example.com"
        viewController.passwordInput.text = "password123"

        let mockUserService = MockUserAuthService()
        viewController.userService = mockUserService

        viewController.login(UIButton())

        XCTAssertTrue(mockUserService.didCallAuthenticate, "authenticate should be called when inputs are valid")
    }
}

class MockUserAuthService: UserService {
    var didCallAuthenticate = false

    override func authenticate(loginData: AuthenticationSchema, completion: @escaping (Result<AuthResponse, AFError>) -> Void) {
        didCallAuthenticate = true
        completion(.success(AuthResponse(access: "moock")))
    }
}
