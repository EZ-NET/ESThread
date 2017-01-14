//
//  Invocation.swift
//  ESSwim
//
//  Created by Tomohiro Kumagai on H27/04/21.
//
//

import Foundation

/// Get main queue.
public let mainQueue = DispatchQueue.main

public var onMainQueue:Bool {

	return Thread.isMainThread
}

/// Invoke `predicate` asynchronously on `queue`.
public func invokeAsync(_ queue:DispatchQueue, predicate:@escaping ()->Void) {
	
	queue.async(execute: predicate)
}

public func invokeAsync(_ queue:DispatchQueue, after delay:Double, predicate:@escaping ()->Void) {
	
	let delta = Int64(delay * Double(NSEC_PER_SEC))
	let time = DispatchTime.now() + Double(delta) / Double(NSEC_PER_SEC)

	queue.asyncAfter(deadline: time, execute: predicate)
}

/// Invoke `predicate` synchronously on `queue`.
public func invoke<Result>(_ queue:DispatchQueue, predicate:()->Result) -> Result {
    
    var result:Result!
    
    queue.sync { () -> Void in
        
        result = predicate()
    }
    
    return result
}

/// Invoke `predicate` synchronously on `queue`.
public func invoke<Result>(_ queue:DispatchQueue, predicate:() throws ->Result) throws -> Result {
	
	var result:Result!
    var resultError: Error? = nil
	
	queue.sync { () -> Void in
		
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
public func invokeAsyncOnMainQueue(_ predicate:@escaping ()->Void) {
 
	invokeAsync(mainQueue, predicate: predicate)
}

public func invokeAsyncOnMainQueue(after delay:Double, predicate:@escaping ()->Void) {
 
	invokeAsync(mainQueue, after: delay, predicate: predicate)
}

/// Invoke `predicate` synchronously on main queue. If this function performed on main thread, invoke `predicate` immediately.
public func invokeOnMainQueue<Result>(_ predicate:()->Result) -> Result {
	
	if onMainQueue {
		
		return predicate()
	}
	else {
		
		return invoke(mainQueue, predicate: predicate)
	}
}

/// Invoke `predicate` synchronously on main queue. If this function performed on main thread, invoke `predicate` immediately.
public func invokeOnMainQueue<Result>(_ predicate:() throws -> Result) throws -> Result {
    
    if onMainQueue {
        
        return try predicate()
    }
    else {
        
        return try invoke(mainQueue, predicate: predicate)
    }
}

/// Invoke `predicate` asynchronously in background.
public func invokeAsyncInBackground(_ predicate:@escaping ()->Void) {
	
	let label = "Swim: " + UUID().description
	let queue = DispatchQueue(label: label, attributes: [])
	
	invokeAsync(queue, predicate: predicate)
}
