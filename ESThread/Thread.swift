//
//  Thread.swift
//  ESSwim
//
//  Created by Tomohiro Kumagai on H27/04/21.
//
//

import Foundation

public func makeQueue(identifier:String) -> dispatch_queue_t {
	
	return makeQueue(identifier, attribute: nil)
}

public func makeQueue(identifier:String, attribute:dispatch_queue_attr_t?) -> dispatch_queue_t {
	
	return dispatch_queue_create(identifier, attribute)
}

public func sleepForSecond(second:Double) {
	
	NSThread.sleepForTimeInterval(second)
}
