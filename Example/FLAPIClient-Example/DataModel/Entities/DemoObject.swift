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
	let url: URL
	
	public var description: String {
		return "url: \(self.url)"
	}
}

extension DemoObject: JSONParseable {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			url: json["args"]["url"]^
		)
	}
	
	func test() {

	}
}


