//
//  APIResult.swift
//  Pods
//
//  Created by Ravindra Soni on 20/07/17.
//
//

import Foundation

public enum APIResult<T> {
	case success(value: T)
	case failure(error: APIError)
}
