//
//  RegistrationConfirmTests.swift
//  CanteenApp
//
//  Created by мак on 11.12.2024.
//
import XCTest
import Alamofire
@testable import CanteenApp


class RegistrationConfirmationTests: XCTestCase {

    var viewController: RegistrationConfirmationViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationConfirmationViewController") as? RegistrationConfirmationViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testInputsAreValidWithValidInput() {
        viewController.codeInput.text = "123456"

        let result = viewController.inputsAreValid()

        XCTAssertTrue(result, "inputsAreValid should return true when code input is filled")
    }

    func testInputsAreValid_withEmptyInput() {
        viewController.codeInput.text = ""

        let result = viewController.inputsAreValid()

        XCTAssertFalse(result, "inputsAreValid should return false when code input is empty")
    }

    func testConfirmRegistrationWithValidInput_callsUserService() {
        viewController.codeInput.text = "123456"
        UserDefaults.standard.set("mockSessionId", forKey: "session_id")

        let mockUserService = MockUserConfirmService()
        viewController.userService = mockUserService

        viewController.confirmRegistration(UIButton())

        XCTAssertTrue(mockUserService.didCallConfirmRegister, "confirmRegister should be called when input is valid")
    }
}

class MockUserConfirmService: UserService {
    var didCallConfirmRegister = false
    
    override func confirmRegister(registrationConfirmData: RegistrationConfirmSchema, completion: @escaping (Result<UserResponse, AFError>) -> Void) {
        didCallConfirmRegister = true
        completion(.success((UserResponse(id: 1, first_name: "String", last_name: "String", email: "String"))))
    }
}
