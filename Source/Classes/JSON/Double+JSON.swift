//
//  Double+JSON.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

extension Double: JSONParseablePrimitive {
	
	public static func transform(_ number: NSNumber) -> Double? {
		return number.doubleValue
	}
	
	public static func transform(_ string: String) -> Double? {
		return Double(string)
	}

	public static func transform(_ json: JSON) -> Double {
		return json.doubleValue
	}

}

