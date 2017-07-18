////
////  JSON.swift
////  JSONParsing
////
////  Created by Ravindra Soni on 16/12/16.
////  Copyright © 2016 Nickelfox. All rights reserved.
////
//
//import Foundation
//
//public final class JSON {
//
//	public enum ParseError: Swift.Error {
//		case noValue(json: JSON)
//		case typeMismatch(json: JSON)
//	}
//
//	public let parentLink: (JSON, String)?
//	public let object: AnyObject?
//
//	public init(_ object: AnyObject?) {
//		self.object = object
//		self.parentLink = nil
//	}
//
//	public init(_ object: AnyObject?, parent: JSON, key: String) {
//		self.object = object
//		self.parentLink = (parent, key)
//	}
//
//	public var pathFromRoot: String {
//		if let (parent, key) = self.parentLink {
//			return "\(parent.pathFromRoot)/\(key)"
//		} else {
//			return ""
//		}
//	}
//
//	public subscript(key: String) -> JSON {
//		let value = (object as? NSDictionary)?[key]
//		return JSON(value as AnyObject?, parent: self, key: key)
//	}
//
//	public var array: [JSON] {
//		if let arr = object as? [AnyObject] {
//			return arr.enumerated().map {
//				idx, item in
//				JSON(item, parent: self, key: "\(idx)")
//			}
//		} else if object is NSNull {
//			return []
//		} else {
//			return [self]
//		}
//	}
//
//	public var optional: JSON? {
//		if object == nil || object is NSNull {
//			return nil
//		} else {
//			return self
//		}
//	}
//
//	public func parse<T: JSONParsing>() throws -> T {
//		return try T.parse(self)
//	}
//
//}
//
//postfix operator ^
//
//public postfix func ^ <T: JSONParsing> (json: JSON) throws -> T {
//	return try json.parse()
//}


import Foundation
import SwiftyJSON

public protocol JSONParsing {
    static func parse(_ json: JSON) throws -> Self
}

public enum ParseError: Error {
	case typeMismatch(json: JSON, expectedType: String)
}

public protocol JSONValue {
	static func optionalValue(_ json: JSON) -> Self?
	static func forcedValue(_ json: JSON) -> Self
}

public protocol JSONParsingPrimitive: JSONParsing, JSONValue {
	static func forceParse(_ json: JSON) -> Self
	static func optionalParse(_ json: JSON) -> Self?
}

public extension JSONParsingPrimitive {

	public static func parse(_ json: JSON) throws -> Self {
		if let error = json.error {
			throw error
		}
		guard let value = Self.optionalValue(json) else {
			throw ParseError.typeMismatch(json: json, expectedType: String(describing: Self.self))
		}
		return value
	}
	
	public static func forceParse(_ json: JSON) -> Self {
		return Self.forcedValue(json)
	}
	
	public static func optionalParse(_ json: JSON) -> Self? {
		return Self.optionalValue(json)
	}

}


extension String: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> String? {
		return json.string
	}
	
	public static func forcedValue(_ json: JSON) -> String {
		return json.stringValue
	}
}

extension Bool: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Bool? {
		return json.bool
	}
	
	public static func forcedValue(_ json: JSON) -> Bool {
		return json.boolValue
	}
}

extension Int: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Int? {
		return json.int
	}
	
	public static func forcedValue(_ json: JSON) -> Int {
		return json.intValue
	}
}

extension Int8: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Int8? {
		return json.int8
	}
	
	public static func forcedValue(_ json: JSON) -> Int8 {
		return json.int8Value
	}
}

extension Int16: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Int16? {
		return json.int16
	}
	
	public static func forcedValue(_ json: JSON) -> Int16 {
		return json.int16Value
	}
}

extension Int32: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Int32? {
		return json.int32
	}
	
	public static func forcedValue(_ json: JSON) -> Int32 {
		return json.int32Value
	}
}

extension Int64: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Int64? {
		return json.int64
	}
	
	public static func forcedValue(_ json: JSON) -> Int64 {
		return json.int64Value
	}
}

extension Double: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Double? {
		return json.double
	}
	
	public static func forcedValue(_ json: JSON) -> Double {
		return json.doubleValue
	}
}

extension Float: JSONParsingPrimitive {
	public static func optionalValue(_ json: JSON) -> Float? {
		return json.float
	}
	
	public static func forcedValue(_ json: JSON) -> Float {
		return json.floatValue
	}
}


public extension JSON {
	
    public var optional: JSON? {
        if let _ = self.error {
            return nil
        } else {
            return self
        }
    }
    
}

postfix operator ^
public postfix func ^ <T: JSONParsing> (json: JSON) throws -> T {
    return try T.parse(json)
}

postfix operator ^~
public postfix func ^~ <T: JSONParsingPrimitive> (json: JSON) -> T {
	return T.forceParse(json)
}

postfix operator ^?
public postfix func ^? <T: JSONParsingPrimitive> (json: JSON) -> T? {
	return T.optionalParse(json)
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

