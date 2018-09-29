//
//  StockXCodeChallengeUITests.swift
//  StockXCodeChallengeUITests
//
//  Created by may on 2018-07-11.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import XCTest

class StockXCodeChallengeUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        if app.wait(for: .runningForeground, timeout: 20) == true {
            
            // Tap a cell
            app.tables.cells.element(boundBy: 5).tap()
            // Go back to TableView
            if app.wait(for: .runningForeground, timeout: 20) == true {
                XCUIApplication().navigationBars["StockXCodeChallenge.WebSiteView"].buttons["r/all"].tap()
            }
            
            // TableView Scrolling Test
            let table = XCUIApplication().tables.element(boundBy:0)
            
            // Get the coordinate for the bottom of the table view
            let tableBottom = table.coordinate(withNormalizedOffset:CGVector(dx: 0.5, dy: 1.0))
            
            // Scroll from tableBottom to new coordinate
            let scrollVector = CGVector(dx: 0.0, dy: -400.0) // Use whatever vector you like
            tableBottom.press(forDuration: 1.0, thenDragTo: tableBottom.withOffset(scrollVector))
            
            // Scroll from tableBottom to new coordinate
            let scrollUpVector = CGVector(dx: 0.0, dy: +400.0) // Use whatever vector you like
            tableBottom.press(forDuration: 1.0, thenDragTo: tableBottom.withOffset(scrollUpVector))
            
            
            // Tap a cell
             app.tables.cells.element(boundBy: 10).tap()
            // Go back to TableView
            if app.wait(for: .runningForeground, timeout: 20) == true {
                XCUIApplication().navigationBars["StockXCodeChallenge.WebSiteView"].buttons["r/all"].tap()
            }
            
            
            
            
        }
    }
}
