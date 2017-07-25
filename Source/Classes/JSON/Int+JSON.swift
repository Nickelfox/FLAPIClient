//
//  Int+JSON.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

extension Int: JSONPrimitveTransfromable {
	
	public static func transform(_ number: NSNumber) -> Int? {
		return number.intValue
	}
	
	public static func transform(_ string: String) -> Int? {
		return Int(string)
	}

	public static func transform(_ json: JSON) -> Int {
		return json.intValue
	}

}

extension Int8: JSONPrimitveTransfromable {
	
	public static func transform(_ number: NSNumber) -> Int8? {
		return number.int8Value
	}
	
	public static func transform(_ string: String) -> Int8? {
		return Int8(string)
	}
	
	public static func transform(_ json: JSON) -> Int8 {
		return json.int8Value
	}

}

extension Int16: JSONPrimitveTransfromable {
	
	public static func transform(_ number: NSNumber) -> Int16? {
		return number.int16Value
	}
	
	public static func transform(_ string: String) -> Int16? {
		return Int16(string)
	}
	
	public static func transform(_ json: JSON) -> Int16 {
		return json.int16Value
	}

}

extension Int32: JSONPrimitveTransfromable {
	
	public static func transform(_ number: NSNumber) -> Int32? {
		return number.int32Value
	}
	
	public static func transform(_ string: String) -> Int32? {
		return Int32(string)
	}
	
	public static func transform(_ json: JSON) -> Int32 {
		return json.int32Value
	}

}

extension Int64: JSONPrimitveTransfromable {
	
	public static func transform(_ number: NSNumber) -> Int64? {
		return number.int64Value
	}
	
	public static func transform(_ string: String) -> Int64? {
		return Int64(string)
	}
	
	public static func transform(_ json: JSON) -> Int64 {
		return json.int64Value
	}

}
