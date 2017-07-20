//
//  APIRequestManager.swift
//  Pods
//
//  Created by Ravindra Soni on 19/07/17.
//
//

import Foundation

open class APIRequestManager {

	private static let defaultParams: [String: Any] = [:]
	private static let defaultHeaders: [String: String] = [:]
	private static let defaultEncoding: URLEncoding = URLEncoding.default
	private static let defaultTimeout: TimeInterval = DefaultTimeoutInterval
	
	public let baseUrl: URL
	public var headers: [String: String] = APIRequestManager.defaultHeaders
	public var encoding: URLEncoding = APIRequestManager.defaultEncoding
	public var timeoutInterval: TimeInterval = APIRequestManager.defaultTimeout
	public var keypathToMap: String? = nil

	public init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}

	public func get(
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil,
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
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

	public func post(
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil,
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
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

	public func put(
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil,
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
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

	public func patch(
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil,
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
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

	public func delete(
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil,
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
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

	public func request(
		method: HTTPMethod, 
		path: String,
		params: [String: Any] = APIRequestManager.defaultParams,
		headers: [String: String]? = nil,
		keypathToMap: String? = nil, 
		encoding: URLEncoding? = nil,
		timeoutInterval: TimeInterval? = nil) -> APIRouter {
		return APIRequest(
			baseUrl: self.baseUrl,
			method: method,
			path: path,
			params: params,
			headers: headers ?? self.headers,
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
	
	public init(baseUrl: URL, method: HTTPMethod, path: String, params: [String: Any] = [:], headers: [String: String] = [:], keypathToMap: String? = nil, encoding: URLEncoding? = nil, timeoutInterval: TimeInterval? = nil) {
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
