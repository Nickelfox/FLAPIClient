//
//  JSONError.swift
//  Pods
//
//  Created by Ravindra Soni on 25/07/17.
//
//

import SwiftyJSON

public enum JSONError: Error {
	case typeMismatch(json: JSON, expectedType: String)
}
