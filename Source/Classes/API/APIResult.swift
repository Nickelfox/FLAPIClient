//
//  APIResult.swift
//  Pods
//
//  Created by Ravindra Soni on 20/07/17.
//
//

import Foundation

enum APIResult<T: JSONParsing> {
	case success(value: T)
	case failure(error: APIError)
}
