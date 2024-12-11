//
//  Untitled.swift
//  CanteenApp
//
//  Created by мак on 11.12.2024.
//
import XCTest
import Alamofire
@testable import CanteenApp


class FoodTableViewControllerTests: XCTestCase {
    var viewController: FoodTableViewController!
    let mockFoodService = MockFoodService()

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "FoodTableViewController") as? FoodTableViewController
        viewController.loadViewIfNeeded()
        
        viewController.foodService = mockFoodService
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testTableViewNumberOfRowsInSection() {
        viewController.foodList = mockFoodService.mockResponse
        let rows = viewController.tableView(viewController.foodListTableView, numberOfRowsInSection: 0)

        XCTAssertEqual(rows, mockFoodService.mockResponse.count, "Number of rows should match the number of food items in the list")
    }

    func testSearchByNameCallsLoadMenu() {
        viewController.searchInput.text = "Pizza"

        viewController.searchByName(UIButton())

        XCTAssertTrue(mockFoodService.didCallGetMenu, "getMenu should be called when searchByName is triggered")
        XCTAssertEqual(mockFoodService.searchQuery, "Pizza", "getMenu should be called with the correct search query")
    }
}

class MockFoodService: FoodService {
    var didCallGetMenu = false
    var searchQuery: String?
    var mockResponse = [
        Food(id: "1", name: "Pizza", description: "", price: 10, image: ""),
        Food(id: "2", name: "Pizza2", description: "", price: 10, image: ""),
        Food(id: "3", name: "Pizza3", description: "", price: 10, image: "")
    ]
    var completionHandler: (() -> Void)?

    override func getMenu(search: String, completion: @escaping (Result<[Food], AFError>) -> Void) {
        didCallGetMenu = true
        searchQuery = search
        completion(.success(self.mockResponse))
    }
}
