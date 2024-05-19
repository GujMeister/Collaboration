//
//  CollaborationTests.swift
//  CollaborationTests
//
//  Created by ana namgaladze on 19.05.24.
//

import XCTest
@testable import Collaboration1
import SimpleNetworking

final class CollaborationTests: XCTestCase {
    //MARK: ---Properties
    var webService: WebService!
    var mockURLSession: URLSession!
    //MARK: ---Methods
    override func setUp() {
        super.setUp()
        webService = WebService()

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        webService = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchCategoriesSuccess() {
        let expectedData = [
            "smartphones",
            "laptops",
            "fragrances",
            "skincare",
            "groceries",
            "home-decoration",
            "furniture",
            "tops",
            "womens-dresses",
            "womens-shoes",
            "mens-shirts",
            "mens-shoes",
            "mens-watches",
            "womens-watches",
            "womens-bags",
            "womens-jewellery",
            "sunglasses",
            "automotive",
            "motorcycle",
            "lighting"
        ]
        
        let jsonData = try! JSONEncoder().encode(expectedData)
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), jsonData)
        }
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        webService.fetchData(from: "https://dummyjson.com/products/categories", resultType: [String].self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
