//
//  APIRouter.swift
//  Network
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//


import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias URLRequestConvertible = Alamofire.URLRequestConvertible
public typealias URLEncoding = Alamofire.URLEncoding

public let DefaultTimeoutInterval: TimeInterval = 200

public protocol APIParams {
	var json: [String: Any] { get }
}

public protocol APIRouter: URLRequestConvertible {
	var method: HTTPMethod { get }
	var path: String { get }
	var params: [String: Any] { get }
	var baseUrl: URL { get }
	var headers: [String: String] { get }
	var encoding: URLEncoding? { get }
	var timeoutInterval: TimeInterval? { get }
	var keypathToMap: String? { get }
}

extension APIRouter {
	public func asURLRequest() throws -> URLRequest {
		var request = URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
		request.httpMethod = self.method.rawValue
		request.timeoutInterval = self.timeoutInterval ?? DefaultTimeoutInterval
		
		for (key, value) in self.headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
		
		var parameters: [String: Any]?
		if self.method == .post || self.method == .patch || self.method == .put {
			do {
				request.httpBody = try JSONSerialization.data(withJSONObject: self.params, options: JSONSerialization.WritingOptions())
			} catch {
				throw error
			}
		} else {
			parameters = params
		}
		let encoding: URLEncoding = self.encoding ?? URLEncoding.default
		return try encoding.encode(request, with: parameters)
	}
}

