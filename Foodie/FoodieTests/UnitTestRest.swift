//
//  UnitTestRest.swift
//  FoodieTests
//
//  Created by Smile. on 18/04/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import XCTest

class UnitTestRest: XCTestCase {
    var systemUnderTest: UIViewController!
    override func setUp() {
        super.setUp()
        let storyboard: UIStoryboard = UIStoryboard(name: "ResturantViewController", bundle: nil)
        systemUnderTest = storyboard.instantiateViewController(withIdentifier: "UIViewController") as! UIViewController
        _ = systemUnderTest.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
