//
//  DemoObject.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient
import SwiftyJSON

enum Test: String, JSONParseRawRepresentable {
	typealias RawValue = String
	case one = "one"
	case two = "two"
	case three
}

public struct DemoObject: CustomStringConvertible {
	let values: [Test]
	
	public var description: String {
		return "values: \(self.values)"
	}
}

extension DemoObject: JSONParseable {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			values: json["args"]["values[]"]^^
		)
	}
	
	func test() {

	}
}


