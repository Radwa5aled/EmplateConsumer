//
//  EmplateConsumerTests.swift
//  EmplateConsumerTests
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import XCTest
import Moya
@testable import EmplateConsumer

class EndPointPostTests: XCTestCase {
    
    var provider: MoyaProvider<EndPointPosts>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = MoyaProvider<EndPointPosts>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        provider = nil
    }
    
    func testCallPostsApi() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expec = self.expectation(description: "sample data from api")
        var message: String?
        
        let target: EndPointPosts = .posts
        provider.request(target) { result in
            switch result {
            case .success(let response):
                
                message = String(data: response.data, encoding: .utf8)
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let genaricModel = try jsonDecoder.decode([PostsModel].self, from: response.data)
                    
                    let sampleData = target.sampleData
                    let sampleModel = try jsonDecoder.decode([PostsModel].self, from: sampleData)
                    
                    
                    expec.fulfill()
                    XCTAssertNotNil(response.data, "response data is nil")
                    XCTAssertNotNil(message, "response data string is nil")
                    XCTAssertNotNil(genaricModel, "decoded model is nil")
                    XCTAssertNotEqual(genaricModel.count, 0, "decoded model count equal 0")
                    XCTAssertNotNil(genaricModel.first?.id, "decoded model first item id equal nil")
                    XCTAssertNotEqual(genaricModel.first?.postfields?.count, 0, "post fields count equal 0 and we need min 1 element to get content that contains price")
                    XCTAssertNotEqual(genaricModel.first?.postperiods?.count, 0, "period fields count equal 0 and we need min 1 element to get start/stop date")
                    XCTAssertNotNil(genaricModel.first?.postfields?.first?.contentObject, "content object is equal nil")
                    
                    XCTAssertEqual(genaricModel[0], sampleModel[0], "first object in response not equal to first object in sample data from json")
                    
                } catch let error {
                    XCTFail(error.localizedDescription)
                }
                
            case .failure:
                XCTFail((result.error?.errorDescription)!)
            }
            
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
    
}
