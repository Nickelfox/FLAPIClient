//
//  DemoObject.swift
//  FLAPIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import FLAPIClient

final public class DemoObject {
	let message = "Success!"
}

extension DemoObject: JSONParsing {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return DemoObject()
	}
}
