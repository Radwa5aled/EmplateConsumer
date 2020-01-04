//
//  UtilitiesTests.swift
//  EmplateConsumerTests
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import XCTest
@testable import EmplateConsumer

class UtilitiesTests: XCTestCase {
    
    var sut:Utilities!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Utilities.shared
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testGetWidth_HeightFactor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let viewWidth:CGFloat = 414
        let width1:CGFloat = 775
        let height1:CGFloat = 630
        
        let result1 = sut.getWidth_HeightFactor(viewWidth:viewWidth, width: width1, height: height1)
        XCTAssertEqual(result1, (viewWidth/width1) * height1) //336.5
        
        //----------------------------------------------------------------------
        let width2:CGFloat = 370
        let height2:CGFloat = 370
        
        let result2 = sut.getWidth_HeightFactor(viewWidth:viewWidth, width: width2, height: height2)
        XCTAssertEqual(result2, (viewWidth/width2) * height2) // 370
        
        //----------------------------------------------------------------------
        let width3:CGFloat = 0
        let height3:CGFloat = 0
        
        let result3 = sut.getWidth_HeightFactor(viewWidth:viewWidth, width: width3, height: height3)
        XCTAssertEqual(result3, 250, "if width or height nil or equal 0 then set default value 250")
        
    }
    
    func testExpirationDateFromCurent() {
        
        let start1 = "2019-12-11T11:00:00+00:00"
        let stop1 = "2019-12-24T11:00:00+00:00"
        
        let result1 = sut.getExpirationDateFromCurent(stopDateStr: stop1, startDateStr: start1)
        
        XCTAssertEqual(result1, "Expired on 24-12-2019", "Error because test date not passed") // passed date
        //----------------------------------------------------------------------
        
        let start2 = "2020-1-1T11:00:00+00:00"
        let stop2 = "2020-1-4T11:00:00+00:00"
        
        let result2 = sut.getExpirationDateFromCurent(stopDateStr: stop2, startDateStr: start2)
        
        XCTAssertEqual(result2, "Expires in 2 hours", "Error bacause test date is not today or hours not equal") //date of today
        //----------------------------------------------------------------------
        
        let start3 = "2020-1-10T11:00:00+00:00"
        let stop3 = "2020-1-15T11:00:00+00:00"
        
        let result3 = sut.getExpirationDateFromCurent(stopDateStr: stop3, startDateStr: start3)
        
        XCTAssertEqual(result3, "Starts in 10-01-2020", "Error because test date is today or passed") // date not come yet
        
    }
    
    
}
