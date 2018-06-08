//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expect = self.expectation(description: "In Progress")
        
        NewsFeed.getData { (data, error) in
            expect.fulfill()
        }
        
        self.wait(for: [expect], timeout: 600)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
