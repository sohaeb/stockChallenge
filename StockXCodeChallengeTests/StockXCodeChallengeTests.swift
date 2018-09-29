//
//  StockXCodeChallengeTests.swift
//  StockXCodeChallengeTests
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import XCTest
@testable import StockXCodeChallenge

class StockXCodeChallengeTests: XCTestCase {
    
    var sessionToTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionToTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionToTest = nil
        super.tearDown()
    }
    
    
    func testDownload(){
        
        let expect = expectation(description: "Download should work")
        let query = Downloader()
        
        query.getSearchResults(url: "https://reddit.com/r/all/.json") { (results, error) in
            
            XCTAssertNil(error, "Unexpected error: \(error?.localizedDescription ?? "no error")")
            XCTAssertNotNil(results, "No payload URL returned")
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed Out")
        }
    }
    
    
    /*
     * Test: success --> fast, failure --> slow
     */
    
    func testValidCallToRedditStatusCode200() {
    
        let url = URL(string: "https://reddit.com/r/wow/.json")
        let expect = expectation(description: "Status code: 200")
        
        let dataTask = sessionToTest.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    expect.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /*
     *  test: faster --> fail
     */
    
    func testToCallReddit() {
    
        let url = URL(string: "https://reddit.com/r/wow/.json")
    
        let expect = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionToTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
        
            expect.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
