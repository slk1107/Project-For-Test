//
//  CoreDataTest.swift
//  Project for TestTests
//
//  Created by Kris on 2020/2/21.
//  Copyright © 2020 Kris. All rights reserved.
//
import XCTest
@testable import Project_for_Test

class CoreDataTest: XCTestCase {

    var coreDataInteractor: DataBaseInteractor!
    

    override func setUp() {
        coreDataInteractor = DataBaseInteractor()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveAndFetch() {
        let expectation = XCTestExpectation(description: "CoreDataInteractor fetchSites")
        let mockInfo = UISiteInfo(title: "Test title \(Date.timeIntervalSinceReferenceDate)", imageURL: URL(fileURLWithPath: "test://testmock"))
        coreDataInteractor.save(siteInfo: mockInfo)
        coreDataInteractor.fetch() {results in
            assert(results != nil)
            if let result = results?.last {
                print("testFetch result: \(result.title), \(result.imageURL)")
                assert(result.title == mockInfo.title)
            } else {
                assert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetch() {
        let expectation = XCTestExpectation(description: "CoreDataInteractor fetchSites")
        coreDataInteractor.fetch() {results in
            DispatchQueue.main.async() {
                assert(results != nil)
                if let result = results?.first {
                    print("testFetch result: \(result.title), \(result.imageURL)")
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
