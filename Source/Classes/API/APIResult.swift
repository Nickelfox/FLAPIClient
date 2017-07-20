//
//  APIResult.swift
//  Pods
//
//  Created by Ravindra Soni on 20/07/17.
//
//

import Foundation

public enum APIResult<Value> {
	case success(Value)
	case failure(APIError)
}
