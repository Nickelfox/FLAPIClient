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
	let origin: String
	let url: String
	
	public var description: String {
		return "origin: \(self.origin), url: \(self.url)"
	}
}

extension DemoObject: JSONParsing {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			origin: json["Connection"]^,
			url: json["Host"]^
		)
	}
}


