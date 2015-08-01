//
//  Invocation.swift
//  ESSwim
//
//  Created by Tomohiro Kumagai on H27/04/21.
//
//

import Foundation

/// Get main queue.
public let mainQueue = dispatch_get_main_queue()

public var onMainQueue:Bool {

	return NSThread.isMainThread()
}

/// Invoke `predicate` asynchronously on `queue`.
public func invokeAsync(queue:dispatch_queue_t, predicate:()->Void) {
	
	dispatch_async(queue, predicate)
}

/// Invoke `predicate` synchronously on `queue`.
public func invokeSync<Result>(queue:dispatch_queue_t, predicate:()->Result) -> Result {
	
	var result:Result!
	
	dispatch_sync(queue) { ()->Void in
		
		result = predicate()
	}
	
	return result
}

/// Invoke `predicate` asynchronously on main queue.
public func invokeAsyncOnMainQueue(predicate:()->Void) {
 
	invokeAsync(mainQueue, predicate: predicate)
}

/// Invoke `predicate` synchronously on main queue. If this function performed on main thread, invoke `predicate` immediately.
public func invokeSyncOnMainQueue<Result>(predicate:()->Result) -> Result {
	
	if onMainQueue {
		
		return predicate()
	}
	else {
		
		return invokeSync(mainQueue, predicate: predicate)
	}
}

/// Invoke `predicate` asynchronously in background.
public func invokeAsyncInBackground(predicate:()->Void) {
	
	let label = "Swim: " + NSUUID().description
	let queue = dispatch_queue_create(label, nil)
	
	invokeAsync(queue, predicate: predicate)
}
