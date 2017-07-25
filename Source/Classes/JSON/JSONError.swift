//
//  JSONError.swift
//  APIClient
//
//  Created by Ravindra Soni on 25/07/17.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import SwiftyJSON

public enum JSONError: Error {
	case typeMismatch(json: JSON, expectedType: String)
	case invalidTransform(json: JSON, fromType: String, toType: String)
}
