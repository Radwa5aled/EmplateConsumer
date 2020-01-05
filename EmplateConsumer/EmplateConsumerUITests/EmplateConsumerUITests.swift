//
//  EmplateConsumerUITests.swift
//  EmplateConsumerUITests
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import XCTest

class EmplateConsumerUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        app = nil
        super.tearDown()
    }
    
    private func testForCellExistence() {
        
        let detailstable = app.tables.matching(identifier: Constants.postsTableAccessIdntefier)
        let firstCell = detailstable.cells.element(matching: .cell, identifier: "tVC_0_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "tableView first cell not exist")
    }
    
    
    private func testForCellSelection() {
        let detailstable = app.tables.matching(identifier: Constants.postsTableAccessIdntefier)
        let firstCell = detailstable.cells.element(matching: .cell, identifier: "tVC_0_0")
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "tableView first cell selection disabled")
        firstCell.tap()
    }
    
}
