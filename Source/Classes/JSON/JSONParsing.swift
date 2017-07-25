//
//  JSONParsing.swift
//  APIClient
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import SwiftyJSON

public protocol JSONParsing {
	static func parse(_ json: JSON) throws -> Self
}

public enum ParseError: Error {
	case typeMismatch(json: JSON, expectedType: String)
}

public extension JSON {
	
	public var optional: JSON? {
		if let _ = self.error {
			return nil
		} else {
			return self
		}
	}

	public func jsonAtKeyPath(keypath: String) -> JSON {
		return self.jsonAtKeyPaths(keypaths: keypath.components(separatedBy: "."))
	}

	public func jsonAtKeyPaths(keypaths: [String]) -> JSON {
		if keypaths.isEmpty {
			return self
		}
		var remainingKeypaths: [String] = []
		if keypaths.count > 1 {
			remainingKeypaths = Array(keypaths[1...keypaths.count-1])
		}
		return self[keypaths.first!].jsonAtKeyPaths(keypaths: remainingKeypaths)
	}
	
}

postfix operator ^
public postfix func ^ <T: JSONParsing> (json: JSON) throws -> T {
	return try T.parse(json)
}

postfix operator ^?
public postfix func ^? <T: JSONParsing> (json: JSON) -> T? {
	return try? T.parse(json)
}

// For Enums
public protocol JSONParsingRawRepresentable: RawRepresentable, JSONParsing {
	associatedtype RawValue: JSONParsing
}

public extension JSONParsingRawRepresentable {
	
	public static func parse(_ json: JSON) throws -> Self {
		if let enumVal = try Self(rawValue: json^) {
			return enumVal
		} else {
			throw ParseError.typeMismatch(json: json, expectedType: String(describing: Self.self))
		}
	}
	
}
