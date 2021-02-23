//
//  jsonPractice1Tests.swift
//  jsonPractice1Tests
//
//  Created by Varuni R on 1/23/21.
//

import XCTest
@testable import ClassifiedsApp

class ClassifiedsAppTests: XCTestCase {
    var viewModel: ResultsViewModel!
    
    override func setUpWithError() throws {
        viewModel = ResultsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testProductDataAcces() {
        let products = [Products(name: "iPhone 11", price: "100.0", created_at: "2021-01-09", image_urls: ["Sample image url"], image_urls_thumbnails: ["Sample thumbnail url"]), Products(name: "iPhone 12", price: "150.0", created_at: "2021-01-09", image_urls: ["Sample image url"], image_urls_thumbnails: ["Sample thumbnail url"])]
           let results = Results(results: products)
           XCTAssertEqual(results.results.count, 2, "Product creation failed")
           let product = results.results.first
           XCTAssertEqual(product?.name, "iPhone 11", "Product name creation failed")
           XCTAssertEqual(product?.price, "100.0", "Product price creation failed")
       }
    
    func testFetchingFromServer() {
        let promise = expectation(description: "Received service response")
        viewModel.fetchProductsList { (completed) in
            if completed {
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 10)
        XCTAssertTrue(viewModel.products.count > 0, "Fetching from server failed")
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    
    }

}
