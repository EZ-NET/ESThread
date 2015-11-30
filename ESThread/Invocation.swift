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

public func invokeAsync(queue:dispatch_queue_t, after delay:Double, predicate:()->Void) {
	
	let delta = Int64(delay * Double(NSEC_PER_SEC))
	let time = dispatch_time(DISPATCH_TIME_NOW, delta)

	dispatch_after(time, queue, predicate)
}

/// Invoke `predicate` synchronously on `queue`.
public func invoke<Result>(queue:dispatch_queue_t, predicate:()->Result) -> Result {
    
    var result:Result!
    
    dispatch_sync(queue) { () -> Void in
        
        result = predicate()
    }
    
    return result
}

/// Invoke `predicate` synchronously on `queue`.
public func invoke<Result>(queue:dispatch_queue_t, predicate:() throws ->Result) throws -> Result {
	
	var result:Result!
    var resultError: ErrorType? = nil
	
	dispatch_sync(queue) { () -> Void in
		
        do {

            result = try predicate()
        }
        catch {
            
            resultError = error
        }
	}
    
    if let error = resultError {
    
        throw error
    }
	
	return result
}

/// Invoke `predicate` asynchronously on main queue.
public func invokeAsyncOnMainQueue(predicate:()->Void) {
 
	invokeAsync(mainQueue, predicate: predicate)
}

public func invokeAsyncOnMainQueue(after delay:Double, predicate:()->Void) {
 
	invokeAsync(mainQueue, after: delay, predicate: predicate)
}

/// Invoke `predicate` synchronously on main queue. If this function performed on main thread, invoke `predicate` immediately.
public func invokeOnMainQueue<Result>(predicate:()->Result) -> Result {
	
	if onMainQueue {
		
		return predicate()
	}
	else {
		
		return invoke(mainQueue, predicate: predicate)
	}
}

/// Invoke `predicate` synchronously on main queue. If this function performed on main thread, invoke `predicate` immediately.
public func invokeOnMainQueue<Result>(predicate:() throws -> Result) throws -> Result {
    
    if onMainQueue {
        
        return try predicate()
    }
    else {
        
        return try invoke(mainQueue, predicate: predicate)
    }
}

/// Invoke `predicate` asynchronously in background.
public func invokeAsyncInBackground(predicate:()->Void) {
	
	let label = "Swim: " + NSUUID().description
	let queue = dispatch_queue_create(label, nil)
	
	invokeAsync(queue, predicate: predicate)
}
