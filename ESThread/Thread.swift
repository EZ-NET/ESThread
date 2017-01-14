//
//  Thread.swift
//  ESSwim
//
//  Created by Tomohiro Kumagai on H27/04/21.
//
//

import Foundation

public func makeQueue(_ identifier:String) -> DispatchQueue {
	
	return makeQueue(identifier, attribute: nil)
}

public func makeQueue(_ identifier:String, attribute:DispatchQueue.Attributes?) -> DispatchQueue {
	
	return DispatchQueue(label: identifier, attributes: attribute!)
}

public func sleepForSecond(_ second:Double) {
	
	Thread.sleep(forTimeInterval: second)
}
