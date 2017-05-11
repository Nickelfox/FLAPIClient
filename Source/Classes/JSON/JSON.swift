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


public extension JSON {
    public var date: Date? {
        /*		switch self.type {
         case .String:
         return LilyDateFormatter.jsonDateFormatter.date(from: self.object as! String)
         default:
         return nil
         }
         */
        return nil
    }
}

public class LilyDateFormatter {
    private static var internalJSONDateFormatter: DateFormatter?
    
    static var jsonDateFormatter: DateFormatter {
        guard let formatter = internalJSONDateFormatter else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            internalJSONDateFormatter = formatter
            return formatter
        }
        return formatter
    }
}


public enum ParseError: Error {
    case noValue(json: JSON)
    case typeMismatch(json: JSON)
}


public protocol JSONParsingPrimitive: JSONParsing {}

public extension JSONParsingPrimitive {
    
}

extension String: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> String {
        if let error = json.error {
            throw error
        }
        guard let _ = json.string else {
            throw ParseError.noValue(json: json)
        }
        return json.stringValue
    }
    
}

extension Bool: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Bool {
        if let error = json.error {
            throw error
        }
        guard let _ = json.bool else {
            throw ParseError.noValue(json: json)
        }
        return json.boolValue
    }
    
}

extension Int: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Int {
        if let error = json.error {
            throw error
        }
        guard let _ = json.int else {
            throw ParseError.noValue(json: json)
        }
        return json.intValue
    }
    
}

extension Int8: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Int8 {
        if let error = json.error {
            throw error
        }
        guard let _ = json.int8 else {
            throw ParseError.noValue(json: json)
        }
        return json.int8Value
    }
    
}

extension Int16: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Int16 {
        if let error = json.error {
            throw error
        }
        guard let _ = json.int16 else {
            throw ParseError.noValue(json: json)
        }
        return json.int16Value
    }
    
}

extension Int32: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Int32 {
        if let error = json.error {
            throw error
        }
        guard let _ = json.int32 else {
            throw ParseError.noValue(json: json)
        }
        return json.int32Value
    }
    
}

extension Int64: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Int64 {
        if let error = json.error {
            throw error
        }
        guard let _ = json.int64 else {
            throw ParseError.noValue(json: json)
        }
        return json.int64Value
    }
    
}

extension Double: JSONParsingPrimitive {
    
    public static func parse(_ json: JSON) throws -> Double {
        if let error = json.error {
            throw error
        }
        guard let _ = json.double else {
            throw ParseError.noValue(json: json)
        }
        return json.doubleValue
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
    
    func parse<T: JSONParsing>() throws -> T {
        return try T.parse(self)
    }
    
}

postfix operator ^

public postfix func ^ <T: JSONParsing> (json: JSON) throws -> T {
    return try json.parse()
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
            throw ParseError.typeMismatch(json: json)
        }
    }
    
}

