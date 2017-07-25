//
//  Bool+JSON.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

extension Bool: JSONParseablePrimitive {
	
	public static func transform(_ number: NSNumber) -> Bool? {
		return number.boolValue
	}
	
	public static func transform(_ string: String) -> Bool? {
		switch string.lowercased() {
		case "true", "t", "y", "yes", "1", "success":
			return true
		case "false", "f" , "n", "no", "0", "failure", "fail":
			return false
		default:
			return nil
		}
	}
	
	public static func transform(_ json: JSON) -> Bool {
		return json.boolValue
	}

}
