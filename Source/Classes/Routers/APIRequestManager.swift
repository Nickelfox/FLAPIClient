//
//  APIRequestManager.swift
//  Pods
//
//  Created by Ravindra Soni on 19/07/17.
//
//

import Foundation

public class APIRequestManager {

	public let baseUrl: URL
	public var headers: [String: String] = [:]
	public var encoding: URLEncoding = URLEncoding.default
	public var timeoutInterval: TimeInterval = DefaultTimeoutInterval
	public var keypathToMap: String? = nil

	public init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}

	public func get(path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return self.request(
			method: .get,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding,
			timeoutInterval: timeoutInterval
		)
	}

	public func post(path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return self.request(
			method: .post,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding,
			timeoutInterval: timeoutInterval
		)
	}

	public func put(method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return self.request(
			method: .put,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding,
			timeoutInterval: timeoutInterval
		)
	}

	public func patch(method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return self.request(
			method: .patch,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding,
			timeoutInterval: timeoutInterval
		)
	}

	public func delete(method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return self.request(
			method: .delete,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding,
			timeoutInterval: timeoutInterval
		)
	}

	public func request(method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) -> APIRouter {
		return APIRequest(
			baseUrl: self.baseUrl,
			method: method,
			path: path,
			params: params,
			headers: headers,
			keypathToMap: keypathToMap,
			encoding: encoding ?? self.encoding,
			timeoutInterval: timeoutInterval ?? self.timeoutInterval
		)
	}
	
}

public struct APIRequest: APIRouter {

	public let baseUrl: URL
	public let method: HTTPMethod
	public let path: String
	public let params: [String: Any]
	public let headers: [String: String]
	public let encoding: URLEncoding?
	public let timeoutInterval: TimeInterval?
	public let keypathToMap: String?
	
	public init(baseUrl: URL, method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval?) {
		self.baseUrl = baseUrl
		self.method = method
		self.path = path
		self.params = params
		self.headers = headers
		self.encoding = encoding
		self.timeoutInterval = timeoutInterval
		self.keypathToMap = keypathToMap
	}

}
