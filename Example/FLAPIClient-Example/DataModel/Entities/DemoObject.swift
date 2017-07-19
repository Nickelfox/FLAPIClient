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

//Data: {
//	"args": {},
//	"headers": {
//		"Accept": "*/*",
//		"Accept-Encoding": "gzip, deflate",
//		"Accept-Language": "en-us",
//		"Connection": "close",
//		"Content-Type": "application/json",
//		"Host": "httpbin.org",
//		"User-Agent": "FLAPIClient-Example/1 CFNetwork/811.4.18 Darwin/16.6.0"
//	},
//	"origin": "49.36.1.237",
//	"url": "https://httpbin.org/get"
//}
public struct DemoObject: CustomStringConvertible {
	let origin: String
	let url: Int
	
	public var description: String {
		return "origin: \(self.origin), url: \(self.url)"
	}
}

extension DemoObject: JSONParsing {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			origin: json["origin"]^,
			url: json["url"]^
		)
	}
}


