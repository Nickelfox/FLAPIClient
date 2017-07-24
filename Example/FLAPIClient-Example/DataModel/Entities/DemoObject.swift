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

public struct DemoObject: CustomStringConvertible {
	let status: Bool
	
	public var description: String {
		return "status: \(self.status ? "true" : "false")"
	}
}

extension DemoObject: JSONParsing {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			status: json["args"]["status"]^
		)
	}
	
	func test() {

	}
}


