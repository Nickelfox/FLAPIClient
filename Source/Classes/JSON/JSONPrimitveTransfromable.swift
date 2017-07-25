//
//  JSONPrimitveTransfromable.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

public protocol JSONPrimitveTransfromable: JSONParsing {
	static func transform(_ number: NSNumber) -> Self?
	static func transform(_ string: String) -> Self?
	static func transform(_ json: JSON) -> Self
}

public extension JSONParsing where Self: JSONPrimitveTransfromable {
	
	static func optionalValue(_ json: JSON) -> Self? {
		if json.type == .number {
			return Self.transform(json.object as! NSNumber)
		} else if json.type == .string {
			return Self.transform(json.object as! String)
		} else if json.type == .bool {
			return Self.transform(NSNumber(value: json.object as! Bool))
		} else {
			return nil
		}
	}
	
	public static func parse(_ json: JSON) throws -> Self {
		if let error = json.error {
			throw error
		}
		guard let value = Self.optionalValue(json) else {
			throw ParseError.typeMismatch(json: json, expectedType: String(describing: Self.self))
		}
		return value
	}
	
	static func forceParse(_ json: JSON) -> Self {
		return Self.transform(json)
	}
	
}
