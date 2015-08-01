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
import ESTestKit

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
		
		invokeSyncOnMainQueue { ()->Void in
			
			expected().success(onMainQueue)

			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
		expected("Execute this line after finished a task.").success(invoked)
	}

	func testInvokeAsyncOnMainThread() {
		
		var invoked:Bool = false
		
		invokeAsyncOnMainQueue { ()->Void in
			
			expected().success(onMainQueue)
			
			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
		unexpected("Execute this line before finish a task.").success(invoked)
	}
	
	func testInvokeAsyncInBackground() {
		
		var invoked:Bool = false
		
		invokeAsyncInBackground { ()->Void in
			
			unexpected().success(onMainQueue)
			
			invoked = true
			
			sleepForSecond(ThreadTests.sleepTime)
		}
		
		unexpected("Execute this line before finish a background task.").success(invoked)
	}
}
