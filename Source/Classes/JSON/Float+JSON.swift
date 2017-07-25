//
//  Float+JSON.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

extension Float: JSONParseablePrimitive {
	
	public static func transform(_ number: NSNumber) -> Float? {
		return number.floatValue
	}
	
	public static func transform(_ string: String) -> Float? {
		return Float(string)
	}
	
	public static func transform(_ json: JSON) -> Float {
		return json.floatValue
	}

}
