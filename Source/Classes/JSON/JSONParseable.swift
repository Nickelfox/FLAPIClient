//
//  JSONParseable.swift
//  APIClient
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import SwiftyJSON

public protocol JSONParseable {
	static func parse(_ json: JSON) throws -> Self
}

postfix operator ^
public postfix func ^ <T: JSONParseable> (json: JSON) throws -> T {
	return try T.parse(json)
}

postfix operator ^?
public postfix func ^? <T: JSONParseable> (json: JSON) -> T? {
	return try? T.parse(json)
}
