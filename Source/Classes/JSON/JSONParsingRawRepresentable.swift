//
//  JSONParseableRawRepresentable.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

// For Enums
public protocol JSONParseableRawRepresentable: RawRepresentable, JSONParseable {
	associatedtype RawValue: JSONParseable
}

public extension JSONParseableRawRepresentable {
	
	public static func parse(_ json: JSON) throws -> Self {
		if let enumVal = try Self(rawValue: json^) {
			return enumVal
		} else {
			throw JSONError.typeMismatch(json: json, expectedType: String(describing: Self.self))
		}
	}
	
}
