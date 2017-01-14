//
//  ThreadTests.swift
//  ESSwim
//
//  Created by Tomohiro Kumagai on H27/04/21.
//
//

import Foundation
import XCTest
import ESThread

class ThreadTests: XCTestCase {

	static let sleepTime:Double = 0.5
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInvokeSyncOnMainThread() {

		var invoked:Bool = false
		
		invokeOnMainQueue { ()->Void in
			
            XCTAssertTrue(onMainQueue)

			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
        XCTAssertTrue(invoked, "Execute this line after finished a task.")
	}

	func testInvokeAsyncOnMainThread() {
		
		var invoked:Bool = false
		
		invokeAsyncOnMainQueue { ()->Void in
			
            XCTAssertTrue(onMainQueue)
			
			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
        XCTAssertFalse(invoked, "Execute this line before finished a task.")
	}
	
	func testInvokeAsyncInBackground() {
		
		var invoked:Bool = false
		
		invokeAsyncInBackground { ()->Void in
			
            XCTAssertFalse(onMainQueue)
			
			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
        XCTAssertFalse(invoked, "Execute this line before finished a background task.")
	}
}
